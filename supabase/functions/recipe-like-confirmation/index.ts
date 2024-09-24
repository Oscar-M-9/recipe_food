import { createClient } from 'npm:@supabase/supabase-js@2'
import { JWT } from 'npm:google-auth-library@9'

interface RecipeLike {
  id: number;
  user_id: string;
  recipe_id: string;
}

interface WebhookPayload {
  type: 'INSERT'
  table: string
  record: RecipeLike
  schema: 'public',
  old_record: null | RecipeLike
}

const supabase = createClient(
  Deno.env.get('SUPABASE_URL')!,
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
)


Deno.serve(async (req) => {
  const payload: WebhookPayload = await req.json()

  // Datos del usuario que dio like 
  const { data: dataUser, error: errorUser } = await supabase
    .from('users')
    .select('*')
    .eq('id', payload.record.user_id)
    .single();
  if (errorUser || !dataUser) {
    return new Response(
      JSON.stringify({ error: 'User not found' }),
      { status: 400, headers: { 'Content-Type': 'application/json' } },
    );
  }

  // Datos de la receta
  const { data: dataRecipe, error: errorRecipe } = await supabase
    .from('recipes')
    .select('*')
    .eq('id', payload.record.recipe_id)
    .single();

  if (errorRecipe || !dataRecipe) {
    return new Response(
      JSON.stringify({ error: 'Recipe not found' }),
      { status: 400, headers: { 'Content-Type': 'application/json' } },
    );
  }

  // Datos del usuario de la receta
  const { data: dataUserRecipe, error: errorUserRecipe } = await supabase
    .from('users')
    .select('*')
    .eq('id', dataRecipe.user_id)  // Asegúrate de que dataRecipe tiene user_id
    .single();

  if (errorUserRecipe || !dataUserRecipe) {
    return new Response(
      JSON.stringify({ error: 'Recipe user not found' }),
      { status: 400, headers: { 'Content-Type': 'application/json' } },
    );
  }

  // Datos de los user_devices obteniendo los fcmTokens del usuario
  const { data: dataUserDevices, error: errorUserDevices } = await supabase
    .from('user_devices')
    .select('*')
    .eq('user_id', dataUserRecipe.id);

    console.log("dataUserDevices", dataUserDevices);


  if (errorUserDevices || !dataUserDevices) {
    return new Response(
      JSON.stringify({ error: 'Devices user not found' }),
      { status: 400, headers: { 'Content-Type': 'application/json' } },
    );
  }

  // const fcmToken = dataUserRecipe!.fcm_token as String
  console.log("dataUser.id != dataUserRecipe.id", dataUser.id != dataUserRecipe.id);
  if (dataUser.id != dataUserRecipe.id){
    const { default: serviceAccount } = await import('../service-account.json', { 
      with : { type: 'json' } 
    })
  
    const accessToken = await getAccessToken({
      clientEmail: serviceAccount.client_email,
      privateKey: serviceAccount.private_key,
    })
  
    const project_id = serviceAccount.project_id
  
    const invalidTokens : string[] = []

    const results = []
  
    for (const device of dataUserDevices) {
      const fcmToken = device.fcm_token as String
      console.log("Fcm token",fcmToken);
      
      const res = await fetch(
        `https://fcm.googleapis.com/v1/projects/${project_id}/messages:send`,
        {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${accessToken}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            message: {
              token: fcmToken,
              notification: {
                title: `${dataUser.name} le a gustado tu receta`,
                body: `¡${dataUser.name} le ha dado like a tu receta ${dataRecipe.title}!`,
              },
              data: {
                recipe_id: payload.record.recipe_id,
                user_id: payload.record.user_id,
              },
              android: {
                notification: {
                  sound: 'default',  // Definir el sonido aquí para Android
                },
              },
              apns: {
                payload: {
                  aps: {
                    sound: 'default',  // Definir el sonido aquí para iOS
                  },
                },
              },
            },
          }),
        }
      )
  
      const resData = await res.json()
      console.log("resData ", resData) 

      // if (res.status < 200 || 299 < res.status) {
      //   throw resData
      // }
  
      if (res.status < 200 || res.status > 299){
        // Verificar si el error indica un token inválido
        if (resData.error && resData.error.message === 'InvalidRegistration') {
          invalidTokens.push(fcmToken)
        } else {
          throw resData
        }
      }
      results.push(resData)
    }
  
    // Eliminar tokens inválidos de supabase
    if (invalidTokens.length > 0){
      const { data: dataDeleted, error: errorDeleted } = await supabase
        .from('user_devices')
        .delete()
        .in('fcm_token', invalidTokens)
  
      if (errorDeleted) {
        console.error('Error al eliminar tokens inválidos:', errorDeleted)
      }
    }
  
  
    return new Response(
      JSON.stringify(results),
      { headers: { "Content-Type": "application/json" } },
    )
  }
  console.log("no se le puede enviar notificacion a si mismo")

  return new Response(
    JSON.stringify({message: "no se le puede enviar notificacion a si mismo"}),
    { headers: { "Content-Type": "application/json" } },
  )
  
})

const getAccessToken = ({
  clientEmail,
  privateKey,
} : {
  clientEmail: string,
  privateKey: string,
}): Promise<string> => { 
  return new Promise((resolve, reject) => {
    const jwtClient = new JWT({
      email: clientEmail,
      key: privateKey,
      scopes: ['https://www.googleapis.com/auth/firebase.messaging'],
    })
    jwtClient.authorize((err, tokens) => {
      if (err) {
        reject(err)
        return;
      }
      
      resolve(tokens!.access_token!)
    
    })
  })
}

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/like-confirmation' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/

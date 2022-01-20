


require('./config/conexion')
//incluir modulo express
const express = require('express')

// console.log("imprimiendo: "+JSON.stringify(process.env.port));

// crear app, instacia de express
const app = express()
const port = (process.env.port || 3000);


// express.json() convierte el cuerpo o body de la solicitud en json
app.use(express.json());

//configurar puerto
app.set('port',port)



//muestra definicion de la ruta
//la cual se llamara cuando se reciba una peticion http get
// haciendo referencia al directorio raiz '/'
// app.get('/', (req, res) => {

//     // req => corresponde a la peticion, informacion sobre la solicitud http que provoco el evento

//     //res corresponde a un objeto que devuelve la respuesta http



//     // '/hola'
//     // http://localhost:3000/hola

//     //     ¿Qué es la respuesta HTTP?
//     // La respuesta o HTTP response es el mensaje que envía el servidor al cliente tras haber recibido una petición o HTTP request

//     // envia una respuesta http
//     res.send('<h1>Hola mundo!</h1><br><p>raiz:'+req.url+'</p>')
//     // res.send(req.url)
//     console.log("hola "+req.get('Host'));
    
    
// })



//rutas
const rutas = require('./rutas')
app.use('/api/',rutas)


// iniciar express
//especifica el puerto que queremos que escuhe  
app.listen(app.get('port'), (error) => {
    if(error){
        console.log("error al ejecutar servidor");
    }else{
        console.log(`Example app listening at http://localhost:${port}/api/`)
    }
    
})
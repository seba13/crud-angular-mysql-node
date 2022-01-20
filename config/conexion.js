


const mysql = require('mysql');
const conexion = mysql.createConnection({

    host: 'localhost',
    user: 'root',
    password: '',
    dateStrings:true,
    port: 3306,
    database: 'crud_productos'
})

conexion.connect((error)=>{
    if(error){
        console.log("erro al conectarse a la base de datos "+error)
    }else{
        console.log("conexión exitosa a la base de datos")
    }
})


module.exports = conexion;
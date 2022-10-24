show dbs
use sample_mflix

db.movies.find() //muestra todos los datos

//Listar peliculas del estreno del año 1985

db.movies.find({year:1985})
db.movies.find({year:{$eq:1985}}) // Es para realizar comparaciones $eq

//Listar solo el titulo y año de las peliculas estrenadas en el año 2000
db.movies.find({year:2000},{title:1,year:1}) // Siempre por default se va a mostrar el id autogenerado
db.movies.find({year:{$eq:2000}},{title:1,year:1,_id:0})

//Listar las peliculas q tienen más de una denominación
db.movies.find({"awards.nominations":{$gt:1}})
db.movies.find({"awards.nominations":{$gt:1}},{title:1,"awards.nominations":1,_id:0})

//Indicar cuantas peliculas se estrenaron en el año 2000
db.movies.countDocuments({year:2000})
db.movies.find({year:2000}).count()     // Sale el mismo resultado

//Indicar cuantas peliculas se han estrenado por año
//SQL: select year, count(id) from movies group by year
db.movies.aggregate([
    {
        $group:{_id:"$year",
        quantity:{$count:{}}}
    }
])



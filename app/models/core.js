const client = require('../client');

class CoreModel {

    static tableName = null;

    constructor(data){
        this.id = data.id;
        for (const field of this.constructor.fields){
            this[field] = data[field];
        }
        this.created_at = data.created_at;
        this.updated_at = data.updated_at;
    }

    /**
     * get all records from table
     * @returns {object[]}
     */
    static async find(){

        const result = await client.query(`SELECT * FROM ${this.tableName}`);

        const instanceList = [];

        for(const row of result.rows){
            instanceList.push(new this(row));
        }

        return instanceList;

    }

    /**
     * get one record from table
     * @param {number} id 
     * @returns {object}
     */
    static async findOne(id){

        const result = await client.query(`SELECT * FROM ${this.tableName} WHERE id=$1`, [id]);

        return new this(result.rows[0]);
    }


    async insert(){
        // const preparedQuery = {
        //     text: `INSERT INTO
        //     ${this.constructor.tableName} (${this.constructor.fields.join(',')})
        //     VALUES(
        //         ${this.constructor.fields.map(
        //             (_, index) => '$' + index++).join(',')})`,
        //     // on ne peuet pas se contenter d'envoyer this
        //     // 1. on n'est pas assuré de l'ordre des propriétés
        //     // 2. il pourrait y avoir une ou plusieurs propriétés qui ne sont pas à insérer en BDD
        //     values: this.constructor.fields.map(field => this[field])
        // }
        // console.log(preparedQuery);
        // // const result = await client.query(preparedQuery)
        // const values = [`(
        //     null,
        //     ${this.constructor.fields.map(field => `'${this[field]}'`).join(',')},
        //     now(),
        //     null
        // )`  
        // ]

        const preparedQuery = {
            text: `SELECT * FROM insert_${this.constructor.tableName}($1::json)`,
            values: [this]
        }

        const result = await client.query(preparedQuery);

        return result.rows[0]

    }


}

module.exports = CoreModel;
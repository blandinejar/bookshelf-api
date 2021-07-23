const CoreModel = require('./core');

class BookModel extends CoreModel {

    static tableName = 'book';

    static fields = [
        "id",
        "isbn",
        "orginal_title",
        "title",
        "excerpt",
        "publication_date",
        "language",
        "page_count",
        "cover",
        "publisher_id",
        "created_at",
        "updated_at"
    ];

    constructor(data){
        // exécute le constructeur du CodeModel
        super(data);
        this.publisher = `${process.env.API_ENDPOINT}publisher/${data.publisher_id}`;
    }


    // static async find(){

    //     const result = await client.query(`SELECT * FROM book_with_author_and_genre`);

    //     const instanceList = [];

    //     for(const row of result.rows){
    //         instanceList.push(new this(row));
    //     }

    //     return instanceList;

    // }

}

module.exports = BookModel;
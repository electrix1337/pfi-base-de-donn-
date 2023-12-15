using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Runtime.ConstrainedExecution;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MongoDB.Driver;
using MongoDB.Bson;
using MongoDB.Driver.Core.Configuration;
using System.Diagnostics;
using MongoDB.Bson.Serialization.Attributes;
using System.Collections;

namespace mongoDB_pfi
{
    public class Joueur
    {
        [BsonElement("alias")]
        public string alias;
        [BsonElement("creatures")]
        public BsonDocument creatures;
    }
    public partial class Form1 : Form
    {
        SqlConnection sqlConn = new SqlConnection("Server=DESKTOP-I33L2LK\\SQLEXPRESS;Database=WBdbexp;Trusted_Connection=true");
        private const string connectionStringMongoDB = "mongodb://localhost:27017";
        MongoClient mong = new MongoClient(connectionStringMongoDB);

        IMongoCollection<BsonDocument> bsonJoueurs;

        string aliasConnected = "";
        public Form1()
        {
            InitializeComponent();
            sqlConn.Open();

            IMongoDatabase bsonDB = mong.GetDatabase("mongoStat");
            bsonJoueurs = bsonDB.GetCollection<BsonDocument>("Joueurs");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //connection
            if (nouveau_compte.Checked)
            {
                CreatePlayer();
            }
            else
            {
                Connection();
            }
        }
        void CreatePlayer()
        {
            var document = new BsonDocument
            {
                { "alias", alias.Text },
                { "creatures", new BsonDocument {
                        { "nom", "elf" },
                        { "type", "gentil" },
                        { "nbPoints", 20 }
                    } 
                }
            };

            bsonJoueurs.InsertOne(document);
        }

        public List<BsonDocument> FinPlayer(string alias)
        {
            var filter = Builders<BsonDocument>.Filter.Eq("alias", alias);
            var results = bsonJoueurs.Find(filter).ToList();
            List<BsonDocument> bsons = new List<BsonDocument>();
            foreach (var result in results)
            {
                bsons.Add(result);
            }
            return bsons;
        }
        public List<BsonDocument> FindPlayersElfAmis()
        {
            var filter = Builders<BsonDocument>.Filter.Eq("creatures.nom", "elf");
            var results = bsonJoueurs.Find(filter).ToList();
            List<BsonDocument> bsons = new List<BsonDocument>();
            foreach (var result in results)
            {
                bsons.Add(result);
            }
            return bsons;
        }
        public void Dispose()
        {
            sqlConn.Close();
        }

        void Connection()
        {
            try
            {
                
                status_label.Text = "Status: Connecté";
            }
            catch
            {
                Console.WriteLine("la connection n'a pas été établit correctement");
                status_label.Text = "Status: Déconnecté";
            }
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            aliasConnected = "";
            status_label.Text = "Status: Déconnecté";
        }
    }
}

namespace mongoDB_pfi
{
    partial class Form1
    {
        /// <summary>
        /// Variable nécessaire au concepteur.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Nettoyage des ressources utilisées.
        /// </summary>
        /// <param name="disposing">true si les ressources managées doivent être supprimées ; sinon, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Code généré par le Concepteur Windows Form

        /// <summary>
        /// Méthode requise pour la prise en charge du concepteur - ne modifiez pas
        /// le contenu de cette méthode avec l'éditeur de code.
        /// </summary>
        private void InitializeComponent()
        {
            this.connection = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.mot_de_passe = new System.Windows.Forms.TextBox();
            this.alias = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.status_label = new System.Windows.Forms.Label();
            this.deconnection = new System.Windows.Forms.Button();
            this.nouveau_compte = new System.Windows.Forms.CheckBox();
            this.label3 = new System.Windows.Forms.Label();
            this.nom_label = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.prenom_textbox = new System.Windows.Forms.TextBox();
            this.nom_textbox = new System.Windows.Forms.TextBox();
            this.button2 = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // connection
            // 
            this.connection.Location = new System.Drawing.Point(6, 77);
            this.connection.Name = "connection";
            this.connection.Size = new System.Drawing.Size(104, 23);
            this.connection.TabIndex = 0;
            this.connection.Text = "se connecter";
            this.connection.UseVisualStyleBackColor = true;
            this.connection.Click += new System.EventHandler(this.button1_Click);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.nom_textbox);
            this.groupBox1.Controls.Add(this.prenom_textbox);
            this.groupBox1.Controls.Add(this.nouveau_compte);
            this.groupBox1.Controls.Add(this.nom_label);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.mot_de_passe);
            this.groupBox1.Controls.Add(this.alias);
            this.groupBox1.Controls.Add(this.connection);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(455, 109);
            this.groupBox1.TabIndex = 1;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "connection";
            this.groupBox1.Enter += new System.EventHandler(this.groupBox1_Enter);
            // 
            // mot_de_passe
            // 
            this.mot_de_passe.Location = new System.Drawing.Point(101, 49);
            this.mot_de_passe.Name = "mot_de_passe";
            this.mot_de_passe.Size = new System.Drawing.Size(160, 22);
            this.mot_de_passe.TabIndex = 5;
            // 
            // alias
            // 
            this.alias.Location = new System.Drawing.Point(101, 21);
            this.alias.Name = "alias";
            this.alias.Size = new System.Drawing.Size(160, 22);
            this.alias.TabIndex = 4;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(6, 52);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(89, 16);
            this.label1.TabIndex = 3;
            this.label1.Text = "Mot de passe";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(58, 24);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(37, 16);
            this.label2.TabIndex = 1;
            this.label2.Text = "Alias";
            // 
            // status_label
            // 
            this.status_label.AutoSize = true;
            this.status_label.Location = new System.Drawing.Point(655, 9);
            this.status_label.Name = "status_label";
            this.status_label.Size = new System.Drawing.Size(123, 16);
            this.status_label.TabIndex = 6;
            this.status_label.Text = "Status: Déconnecté";
            // 
            // deconnection
            // 
            this.deconnection.Location = new System.Drawing.Point(660, 29);
            this.deconnection.Name = "deconnection";
            this.deconnection.Size = new System.Drawing.Size(118, 23);
            this.deconnection.TabIndex = 7;
            this.deconnection.Text = "déconnection";
            this.deconnection.UseVisualStyleBackColor = true;
            this.deconnection.Click += new System.EventHandler(this.button1_Click_1);
            // 
            // nouveau_compte
            // 
            this.nouveau_compte.AutoSize = true;
            this.nouveau_compte.Location = new System.Drawing.Point(315, 83);
            this.nouveau_compte.Name = "nouveau_compte";
            this.nouveau_compte.Size = new System.Drawing.Size(132, 20);
            this.nouveau_compte.TabIndex = 6;
            this.nouveau_compte.Text = "Nouveau compte";
            this.nouveau_compte.UseVisualStyleBackColor = true;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(0, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(44, 16);
            this.label3.TabIndex = 8;
            this.label3.Text = "label3";
            // 
            // nom_label
            // 
            this.nom_label.AutoSize = true;
            this.nom_label.Location = new System.Drawing.Point(285, 52);
            this.nom_label.Name = "nom_label";
            this.nom_label.Size = new System.Drawing.Size(39, 16);
            this.nom_label.TabIndex = 9;
            this.nom_label.Text = "Nom:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(267, 24);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(57, 16);
            this.label4.TabIndex = 10;
            this.label4.Text = "Prénom:";
            // 
            // prenom_textbox
            // 
            this.prenom_textbox.Location = new System.Drawing.Point(330, 21);
            this.prenom_textbox.Name = "prenom_textbox";
            this.prenom_textbox.Size = new System.Drawing.Size(117, 22);
            this.prenom_textbox.TabIndex = 11;
            // 
            // nom_textbox
            // 
            this.nom_textbox.Location = new System.Drawing.Point(330, 52);
            this.nom_textbox.Name = "nom_textbox";
            this.nom_textbox.Size = new System.Drawing.Size(117, 22);
            this.nom_textbox.TabIndex = 12;
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(0, 0);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(75, 23);
            this.button2.TabIndex = 9;
            this.button2.Text = "button2";
            this.button2.UseVisualStyleBackColor = true;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.deconnection);
            this.Controls.Add(this.status_label);
            this.Controls.Add(this.groupBox1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button connection;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TextBox mot_de_passe;
        private System.Windows.Forms.TextBox alias;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label status_label;
        private System.Windows.Forms.Button deconnection;
        private System.Windows.Forms.CheckBox nouveau_compte;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label nom_label;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox nom_textbox;
        private System.Windows.Forms.TextBox prenom_textbox;
        private System.Windows.Forms.Button button2;
    }
}


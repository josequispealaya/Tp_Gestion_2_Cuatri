﻿namespace ClinicaFrba.AbmRol
{
    partial class frm_administrar_afiliados
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.but_buscar = new System.Windows.Forms.Button();
            this.but_modificar = new System.Windows.Forms.Button();
            this.but_eliminar = new System.Windows.Forms.Button();
            this.tex_numero_afiliado = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.tex_nombre = new System.Windows.Forms.TextBox();
            this.tex_apellido = new System.Windows.Forms.TextBox();
            this.tex_dni = new System.Windows.Forms.TextBox();
            this.tex_direccion = new System.Windows.Forms.TextBox();
            this.tex_telefono = new System.Windows.Forms.TextBox();
            this.tex_mail = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.rdb_masculino = new System.Windows.Forms.RadioButton();
            this.rdb_femenino = new System.Windows.Forms.RadioButton();
            this.com_plan_medico = new System.Windows.Forms.ComboBox();
            this.Nuevo = new System.Windows.Forms.Button();
            this.label11 = new System.Windows.Forms.Label();
            this.tex_dni_asociado_principal = new System.Windows.Forms.TextBox();
            this.opcional = new System.Windows.Forms.Label();
            this.dtp_fecha_nacimiento = new System.Windows.Forms.DateTimePicker();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 16);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(99, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Numero de Afiliado:";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // but_buscar
            // 
            this.but_buscar.Location = new System.Drawing.Point(205, 13);
            this.but_buscar.Name = "but_buscar";
            this.but_buscar.Size = new System.Drawing.Size(51, 24);
            this.but_buscar.TabIndex = 1;
            this.but_buscar.Text = "Buscar";
            this.but_buscar.UseVisualStyleBackColor = true;
            this.but_buscar.Click += new System.EventHandler(this.but_buscar_Click);
            // 
            // but_modificar
            // 
            this.but_modificar.Location = new System.Drawing.Point(136, 332);
            this.but_modificar.Name = "but_modificar";
            this.but_modificar.Size = new System.Drawing.Size(83, 24);
            this.but_modificar.TabIndex = 3;
            this.but_modificar.Text = "Modificar";
            this.but_modificar.UseVisualStyleBackColor = true;
            // 
            // but_eliminar
            // 
            this.but_eliminar.Location = new System.Drawing.Point(251, 332);
            this.but_eliminar.Name = "but_eliminar";
            this.but_eliminar.Size = new System.Drawing.Size(83, 24);
            this.but_eliminar.TabIndex = 4;
            this.but_eliminar.Text = "Eliminar";
            this.but_eliminar.UseVisualStyleBackColor = true;
            // 
            // tex_numero_afiliado
            // 
            this.tex_numero_afiliado.Location = new System.Drawing.Point(113, 16);
            this.tex_numero_afiliado.Name = "tex_numero_afiliado";
            this.tex_numero_afiliado.Size = new System.Drawing.Size(86, 20);
            this.tex_numero_afiliado.TabIndex = 5;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 62);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(47, 13);
            this.label2.TabIndex = 6;
            this.label2.Text = "Nombre:";
            this.label2.Click += new System.EventHandler(this.label2_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(12, 89);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(47, 13);
            this.label3.TabIndex = 7;
            this.label3.Text = "Apellido:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(12, 116);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(29, 13);
            this.label4.TabIndex = 8;
            this.label4.Text = "DNI:";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(12, 140);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(109, 13);
            this.label5.TabIndex = 9;
            this.label5.Text = "Fecha de nacimiento:";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(12, 168);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(55, 13);
            this.label6.TabIndex = 10;
            this.label6.Text = "Direccion:";
            this.label6.Click += new System.EventHandler(this.label6_Click);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(9, 190);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(52, 13);
            this.label7.TabIndex = 11;
            this.label7.Text = "Telefono:";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(12, 215);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(35, 13);
            this.label8.TabIndex = 12;
            this.label8.Text = "Email:";
            // 
            // tex_nombre
            // 
            this.tex_nombre.Location = new System.Drawing.Point(117, 62);
            this.tex_nombre.Name = "tex_nombre";
            this.tex_nombre.Size = new System.Drawing.Size(204, 20);
            this.tex_nombre.TabIndex = 13;
            // 
            // tex_apellido
            // 
            this.tex_apellido.Location = new System.Drawing.Point(117, 88);
            this.tex_apellido.Name = "tex_apellido";
            this.tex_apellido.Size = new System.Drawing.Size(204, 20);
            this.tex_apellido.TabIndex = 14;
            // 
            // tex_dni
            // 
            this.tex_dni.Location = new System.Drawing.Point(117, 114);
            this.tex_dni.Name = "tex_dni";
            this.tex_dni.Size = new System.Drawing.Size(121, 20);
            this.tex_dni.TabIndex = 15;
            // 
            // tex_direccion
            // 
            this.tex_direccion.Location = new System.Drawing.Point(117, 165);
            this.tex_direccion.Name = "tex_direccion";
            this.tex_direccion.Size = new System.Drawing.Size(86, 20);
            this.tex_direccion.TabIndex = 17;
            // 
            // tex_telefono
            // 
            this.tex_telefono.Location = new System.Drawing.Point(117, 189);
            this.tex_telefono.Name = "tex_telefono";
            this.tex_telefono.Size = new System.Drawing.Size(86, 20);
            this.tex_telefono.TabIndex = 18;
            // 
            // tex_mail
            // 
            this.tex_mail.Location = new System.Drawing.Point(117, 215);
            this.tex_mail.Name = "tex_mail";
            this.tex_mail.Size = new System.Drawing.Size(86, 20);
            this.tex_mail.TabIndex = 19;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(12, 244);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(34, 13);
            this.label9.TabIndex = 20;
            this.label9.Text = "Sexo:";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(12, 269);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(100, 13);
            this.label10.TabIndex = 21;
            this.label10.Text = "Plan medico actual:";
            // 
            // rdb_masculino
            // 
            this.rdb_masculino.AutoSize = true;
            this.rdb_masculino.Location = new System.Drawing.Point(113, 242);
            this.rdb_masculino.Name = "rdb_masculino";
            this.rdb_masculino.Size = new System.Drawing.Size(73, 17);
            this.rdb_masculino.TabIndex = 22;
            this.rdb_masculino.TabStop = true;
            this.rdb_masculino.Text = "Masculino";
            this.rdb_masculino.UseVisualStyleBackColor = true;
            // 
            // rdb_femenino
            // 
            this.rdb_femenino.AutoSize = true;
            this.rdb_femenino.Location = new System.Drawing.Point(205, 242);
            this.rdb_femenino.Name = "rdb_femenino";
            this.rdb_femenino.Size = new System.Drawing.Size(71, 17);
            this.rdb_femenino.TabIndex = 23;
            this.rdb_femenino.TabStop = true;
            this.rdb_femenino.Text = "Femenino";
            this.rdb_femenino.UseVisualStyleBackColor = true;
            // 
            // com_plan_medico
            // 
            this.com_plan_medico.FormattingEnabled = true;
            this.com_plan_medico.Location = new System.Drawing.Point(117, 266);
            this.com_plan_medico.Name = "com_plan_medico";
            this.com_plan_medico.Size = new System.Drawing.Size(121, 21);
            this.com_plan_medico.TabIndex = 24;
            // 
            // Nuevo
            // 
            this.Nuevo.Location = new System.Drawing.Point(15, 332);
            this.Nuevo.Name = "Nuevo";
            this.Nuevo.Size = new System.Drawing.Size(61, 24);
            this.Nuevo.TabIndex = 25;
            this.Nuevo.Text = "Nuevo";
            this.Nuevo.UseVisualStyleBackColor = true;
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(12, 297);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(134, 13);
            this.label11.TabIndex = 26;
            this.label11.Text = "DNI del asociado principal:";
            // 
            // tex_dni_asociado_principal
            // 
            this.tex_dni_asociado_principal.Location = new System.Drawing.Point(147, 293);
            this.tex_dni_asociado_principal.Name = "tex_dni_asociado_principal";
            this.tex_dni_asociado_principal.Size = new System.Drawing.Size(121, 20);
            this.tex_dni_asociado_principal.TabIndex = 27;
            // 
            // opcional
            // 
            this.opcional.AutoSize = true;
            this.opcional.Location = new System.Drawing.Point(274, 300);
            this.opcional.Name = "opcional";
            this.opcional.Size = new System.Drawing.Size(53, 13);
            this.opcional.TabIndex = 28;
            this.opcional.Text = "(opcional)";
            this.opcional.Click += new System.EventHandler(this.opcional_Click);
            // 
            // dtp_fecha_nacimiento
            // 
            this.dtp_fecha_nacimiento.Location = new System.Drawing.Point(128, 140);
            this.dtp_fecha_nacimiento.Name = "dtp_fecha_nacimiento";
            this.dtp_fecha_nacimiento.Size = new System.Drawing.Size(200, 20);
            this.dtp_fecha_nacimiento.TabIndex = 29;
            // 
            // frm_administrar_afiliados
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(377, 394);
            this.Controls.Add(this.dtp_fecha_nacimiento);
            this.Controls.Add(this.opcional);
            this.Controls.Add(this.tex_dni_asociado_principal);
            this.Controls.Add(this.label11);
            this.Controls.Add(this.Nuevo);
            this.Controls.Add(this.com_plan_medico);
            this.Controls.Add(this.rdb_femenino);
            this.Controls.Add(this.rdb_masculino);
            this.Controls.Add(this.label10);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.tex_mail);
            this.Controls.Add(this.tex_telefono);
            this.Controls.Add(this.tex_direccion);
            this.Controls.Add(this.tex_dni);
            this.Controls.Add(this.tex_apellido);
            this.Controls.Add(this.tex_nombre);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.tex_numero_afiliado);
            this.Controls.Add(this.but_eliminar);
            this.Controls.Add(this.but_modificar);
            this.Controls.Add(this.but_buscar);
            this.Controls.Add(this.label1);
            this.Name = "frm_administrar_afiliados";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Administrar Afiliados";
            this.Load += new System.EventHandler(this.frm_administrar_afiliados_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button but_buscar;
        private System.Windows.Forms.Button but_modificar;
        private System.Windows.Forms.Button but_eliminar;
        private System.Windows.Forms.TextBox tex_numero_afiliado;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.TextBox tex_nombre;
        private System.Windows.Forms.TextBox tex_apellido;
        private System.Windows.Forms.TextBox tex_dni;
        private System.Windows.Forms.TextBox tex_direccion;
        private System.Windows.Forms.TextBox tex_telefono;
        private System.Windows.Forms.TextBox tex_mail;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.RadioButton rdb_masculino;
        private System.Windows.Forms.RadioButton rdb_femenino;
        private System.Windows.Forms.ComboBox com_plan_medico;
        private System.Windows.Forms.Button Nuevo;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.TextBox tex_dni_asociado_principal;
        private System.Windows.Forms.Label opcional;
        private System.Windows.Forms.DateTimePicker dtp_fecha_nacimiento;
    }
}
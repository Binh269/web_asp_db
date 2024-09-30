﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using Newtonsoft.Json;
using System.Collections.Generic;
using Read_Db;
using System.Diagnostics;
using Lib_Salt;

namespace web_api
{
    public partial class api : System.Web.UI.Page
    {
        private static string connectionString = "Data Source=.;Initial Catalog=web_quan_ly_57kmt;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            string action = this.Request["action"];

            switch (action)
            {
                case "get_infor":
                    get_status();
                    break;
                case "get_salt":
                    get_salt();
                    break;
                case "login":
                    login();
                    break;
                case "add":
                    add_member();
                    break;
                case "delete":
                    delete_member();
                    break;
                case "update":
                    update();
                    break;
                case "history":
                    get_history();
                    break;
                default:
                    thong_bao_loi();
                    break;
            }
        }

        void add_member()
        {
            string ten = this.Request["ten"];
            int ma_vi_tri = int.Parse(this.Request["ma_vi_tri"]);

            db_sql db = get_db();
            string json = db.add_member(ten, ma_vi_tri); 
            this.Response.Write(json);
        }

        void delete_member()
        {
            int ma_thanh_vien;
            if (!int.TryParse(this.Request["ma_thanh_vien"], out ma_thanh_vien))
            {
                thong_bao_loi(); 
                return;
            }

            db_sql db = get_db();
            string json = db.delete_member(ma_thanh_vien);
            this.Response.Write(json);
        }

        void update()
        {
            int ma_thanh_vien = int.Parse(this.Request["ma_thanh_vien"]);
            int ma_vi_tri = int.Parse(this.Request["ma_vi_tri"]);

            db_sql db = get_db();
            string json = db.update(ma_thanh_vien, ma_vi_tri); 
            this.Response.Write(json);
        }

        void get_history()
        {
            int id = int.Parse(this.Request["ma_thanh_vien"]);
            db_sql db = get_db();
            string json = db.get_history(id);
            this.Response.Write(json);
        }

        void thong_bao_loi()
        {
            string rep = "{\"ok\":false,\"msg\":\"Lỗi rồi nhé, ko có action này!\"}";
            this.Response.Write(rep);
        }
        db_sql get_db()
        {
            db_sql db = new db_sql();
            db.cnstr = "Data Source=.;Initial Catalog=web_quan_ly_57kmt;Integrated Security=True;"; 
            return db;
        }


        void get_status()
        {
            db_sql db = get_db();
            string json = db.get_status();
            this.Response.Write(json);
        }

        void get_salt()
        {
            string uid = this.Request["uid"];
            db_sql db = get_db();
            string json = db.salt(uid);
            this.Response.Write(json);
        }

        void login()
        {
            string uid = this.Request["uid"];
            string pwd = this.Request["pass"];
            db_sql db = get_db();
            Salt salt = new Salt();
            //byte[] hashedPwd = salt.HashSHA1(pwd);
            //string pwdHex = BitConverter.ToString(hashedPwd).Replace("-", "");
            string json = db.login(uid, pwd);
            this.Response.Write(json);
            //try
            //{
            //    string uid = this.Request["user"];
            //    string pwd = this.Request["pass"];

            //    Salt salt = new Salt();
            //    byte[] hashedPwd = salt.HashSHA1(pwd);
            //    string pwdHex = BitConverter.ToString(hashedPwd).Replace("-", "");

            //    db_sql db = get_db();
            //    json = db.login(uid, pwdHex);

            //    //LoginData loginData = JsonConvert.DeserializeObject<LoginData>(json);

            //    if (loginData.ok == 1)
            //    {
            //        this.Session["login"] = loginData;
            //    }
            //}
            //catch (Exception ex)
            //{
            //    json = "{\"ok\":0,\"msg\":\"Lỗi: " + ex.Message + "\"}";
            //}
            //finally
            //{
            //    this.Response.ContentType = "application/json"; 
            //    this.Response.Write(json);
            //}
        }

    }
}

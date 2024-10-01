using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using Newtonsoft.Json;
using System.Collections.Generic;
using Read_Db;
using System.Diagnostics;
using Lib_Salt;
using Capcha;

namespace web_api
{
    public partial class api : System.Web.UI.Page
    {
        private static string connectionString = "Data Source=.;Initial Catalog=web_quan_ly_57kmt;Integrated Security=True";
        private static int loginAttempts = 0; 

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
                case "generate_captcha":
                    GenerateCaptcha();
                    break;
                case "validate_captcha":
                    ValidateCaptcha();
                    break;
                default:
                    thong_bao_loi();
                    break;
            }
        }

        private void ValidateCaptcha()
        {
            string captchaInput = this.Request["captcha"];
            string captchaSession = Session["Captcha"] as string;

            if (string.IsNullOrEmpty(captchaInput) || captchaInput.Equals(captchaSession, StringComparison.OrdinalIgnoreCase) == false)
            {
                this.Response.Write("{\"ok\":0, \"msg\":\"CAPTCHA không đúng.\"}");
            }
            else
            {
                loginAttempts = 0;
                this.Response.Write("{\"ok\":1, \"msg\":\"CAPTCHA hợp lệ.\"}");
            }
        }
        private void GenerateCaptcha()
        {
            CaptchaGenerator captcha = new CaptchaGenerator();
            Session["Captcha"] = captcha.CaptchaCode; 
            byte[] imageBytes = captcha.GenerateCaptchaImage();

            Response.ContentType = "image/png";
            Response.BinaryWrite(imageBytes);
            Response.End();
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

            if (loginAttempts >= 3)
            {
                string captchaInput = this.Request["captcha"];
                string captchaSession = Session["Captcha"] as string;

                if (captchaInput == null || !captchaInput.Equals(captchaSession, StringComparison.OrdinalIgnoreCase))
                {
                    this.Response.Write("{\"ok\":0, \"msg\":\"CAPTCHA không đúng.\"}");
                    return;
                }
            }

            db_sql db = get_db();
            Salt salt = new Salt();
            string json = db.login(uid, pwd);
            this.Response.Write(json);

            if (json.Contains("\"ok\":0"))
            {
                loginAttempts++;
            }
            else
            {
                loginAttempts = 0;
                Session.Remove("Captcha");
            }
        }


    }
}

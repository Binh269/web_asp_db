using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Capcha;


namespace web_api
{
    public partial class GenerateCaptcha : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //CaptchaGenerator generator = new CaptchaGenerator();
            //Session["Captcha"] = generator.CaptchaCode; 

            //byte[] captchaImage = generator.GenerateCaptchaImage();
            //Response.Clear();
            //Response.ContentType = "image/png";
            //Response.BinaryWrite(captchaImage);
            //Response.End();
        }
    }
}
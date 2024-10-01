using Capcha;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Text;
using System.IO;
using System.Text;
using System.Windows.Forms;

namespace login_app
{
    public partial class Form1 : Form
    {
        private Random random = new Random();
        public Form1()
        {
            InitializeComponent();
        }



        private void bt_run_Click(object sender, EventArgs e)
        {
            GenerateNewCaptcha();
        }

        private void GenerateNewCaptcha()
        {
            string currentCapchaText = txt_input.Text;

            string[] imageFiles = Directory.GetFiles("E:\\C#\\NET\\web_simple\\web_apt_db\\web_api\\img\\", "*.jpg");
            if (imageFiles.Length == 0)
                throw new FileNotFoundException("No background images found in img folder.");

            string selectedImagePath = imageFiles[random.Next(imageFiles.Length)];
            Bitmap bitmap = new Bitmap(selectedImagePath);
            Graphics g = Graphics.FromImage(bitmap);
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;

            FontFamily[] fontFamilies;
            using (InstalledFontCollection fonts = new InstalledFontCollection())
            {
                fontFamilies = fonts.Families;
            }

            for (int i = 0; i < currentCapchaText.Length; i++)
            {
                Font font = new Font("Times New Roman", 25, FontStyle.Bold); 
                float angle = random.Next(-10, 10);

                PointF point = new PointF(i * 25 + random.Next(5), random.Next(5, 15));

                g.TranslateTransform(point.X, point.Y);
                g.RotateTransform(angle);
                g.DrawString(currentCapchaText[i].ToString(), font, Brushes.Black, new PointF(0, 0));
                g.RotateTransform(-angle);
                g.TranslateTransform(-point.X, -point.Y);
            }

            for (int i = 0; i < 30; i++)
            {
                int x = random.Next(bitmap.Width);
                int y = random.Next(bitmap.Height);
                g.FillEllipse(Brushes.Gray, x, y, 5, 5);
            }

            g.Dispose(); 

            using (var ms = new MemoryStream())
            {
                bitmap.Save(ms, ImageFormat.Png);
                ptb_img.Image = new Bitmap(ms);
            }

            bitmap.Dispose(); 
        }
    }
}
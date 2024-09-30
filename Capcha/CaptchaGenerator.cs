using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Text;
using System.IO;

namespace Capcha
{
    public class CaptchaGenerator
    {
        private static readonly string AllowedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        public string CaptchaCode { get; private set; }
        private List<string> backgroundImages;

        public CaptchaGenerator()
        {
            CaptchaCode = GenerateCaptchaCode();
            LoadBackgroundImages();
        }

        private void LoadBackgroundImages()
        {
            backgroundImages = new List<string>
            {
                "1.jpg",
                "2.jpg",
                "3.jpg",
                "4.jpg",
                "5.jpg",
                "6.jpg",
                "7.jpg"
            };
        }

        private string GenerateCaptchaCode()
        {
            Random random = new Random();
            char[] chars = new char[6];
            for (int i = 0; i < chars.Length; i++)
            {
                chars[i] = AllowedChars[random.Next(AllowedChars.Length)];
            }
            return new string(chars);
        }

        public byte[] GenerateCaptchaImage()
        {
            Random random = new Random();

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

            for (int i = 0; i < CaptchaCode.Length; i++)
            {
                Font font = new Font("Times New Roman", 25, FontStyle.Bold);
                float angle = random.Next(-10, 10); 

                PointF point = new PointF(i * 25 + random.Next(5), random.Next(5, 15)); 

                g.TranslateTransform(point.X, point.Y);
                g.RotateTransform(angle);
                g.DrawString(CaptchaCode[i].ToString(), font, Brushes.Black, new PointF(0, 0));
                g.RotateTransform(-angle);
                g.TranslateTransform(-point.X, -point.Y);
            }

            for (int i = 0; i < 30; i++)
            {
                int x = random.Next(bitmap.Width);
                int y = random.Next(bitmap.Height);
                g.FillEllipse(Brushes.Gray, x, y, 5, 5);
            }

            using (var ms = new MemoryStream())
            {
                bitmap.Save(ms, ImageFormat.Png);
                return ms.ToArray();
            }
        }
    }
}

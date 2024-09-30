using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Text;
using System.IO;
using System.Text;

namespace Capcha
{
    public class CaptchaGenerator
    {
        private static readonly string AllowedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        public string CaptchaCode { get; private set; }

        public CaptchaGenerator()
        {
            CaptchaCode = GenerateCaptchaCode();
        }

        // Hàm sinh mã CAPTCHA ngẫu nhiên gồm 6 ký tự
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

        // Hàm tạo ảnh CAPTCHA với các ký tự nghiêng ngẫu nhiên từ 0 đến 45 độ
        public byte[] GenerateCaptchaImage()
        {
            int width = 200; // Chiều rộng ảnh CAPTCHA
            int height = 80; // Chiều cao ảnh CAPTCHA
            Random random = new Random();

            Bitmap bitmap = new Bitmap(width, height);
            Graphics g = Graphics.FromImage(bitmap);
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
            g.Clear(Color.White); // Nền trắng

            // Đặt phông chữ và kiểu chữ
            FontFamily[] fontFamilies;
            using (InstalledFontCollection fonts = new InstalledFontCollection())
            {
                fontFamilies = fonts.Families;
            }

            for (int i = 0; i < CaptchaCode.Length; i++)
            {
                // Chọn font ngẫu nhiên
                Font font = new Font(fontFamilies[random.Next(fontFamilies.Length)], 36, FontStyle.Bold);
                float angle = random.Next(-45, 45); // Nghiêng ngẫu nhiên từ -45 đến 45 độ

                // Tạo điểm vẽ cho mỗi ký tự
                PointF point = new PointF(i * 30 + random.Next(5), random.Next(10, 40));

                // Xoay ký tự trước khi vẽ
                g.TranslateTransform(point.X, point.Y);
                g.RotateTransform(angle);
                g.DrawString(CaptchaCode[i].ToString(), font, Brushes.Black, new PointF(0, 0));
                g.RotateTransform(-angle);
                g.TranslateTransform(-point.X, -point.Y);
            }

            // Làm mờ và thêm nhiễu ảnh (nếu muốn)
            for (int i = 0; i < 30; i++)
            {
                int x = random.Next(width);
                int y = random.Next(height);
                g.FillEllipse(Brushes.Gray, x, y, 5, 5);
            }

            // Chuyển đổi bitmap sang byte[]
            using (var ms = new System.IO.MemoryStream())
            {
                bitmap.Save(ms, ImageFormat.Png);
                return ms.ToArray();
            }
        }
    }
}
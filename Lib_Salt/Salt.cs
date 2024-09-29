using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;

namespace Lib_Salt
{
    public class Salt
    {
        public byte[] HashSHA1(string input)
        {
            using (SHA1 sha1 = SHA1.Create())
            {
                byte[] inputBytes = Encoding.UTF8.GetBytes(input);
                byte[] hashBytes = sha1.ComputeHash(inputBytes);
                return hashBytes;
            }
        }
    }
}

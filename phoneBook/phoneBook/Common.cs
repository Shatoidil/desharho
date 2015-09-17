using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace phoneBook
{
    public static class Common
    {
        #region Массив в строку
        /// <summary>
        /// Преобразование массива типа byte[] в string
        /// </summary>
        /// <param name="arrInput">Входной массив типа byte[]</param>
        /// <returns>Строка типа string</returns>
        public static string ByteArrayToString(byte[] arrInput)
        {
            int i;
            StringBuilder sOutput = new StringBuilder(arrInput.Length);
            for (i = 0; i < arrInput.Length; i++) sOutput.Append(arrInput[i].ToString("X2"));
            return sOutput.ToString();
        }
        #endregion
    }
}
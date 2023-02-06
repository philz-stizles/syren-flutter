class SignUpOTPTemplate {
  static String template =
      '''<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:v="urn:schemas-microsoft-com:vml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0;" />
    <!--[if !mso]--><!-- -->
    <link href='https://fonts.googleapis.com/css?family=Work+Sans:300,400,500,600,700' rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Quicksand:300,400,700' rel="stylesheet">
    <!--<![endif]-->

    <title>Syren</title>

    <style type="text/css">
        body {
            width: 100%;
            background-color: #ffffff;
            margin: 0;
            padding: 0;
            -webkit-font-smoothing: antialiased;
            mso-margin-top-alt: 0px;
            mso-margin-bottom-alt: 0px;
            mso-padding-alt: 0px 0px 0px 0px;
        }

        p,
        h1,
        h2,
        h3,
        h4 {
            margin-top: 0;
            margin-bottom: 0;
            padding-top: 0;
            padding-bottom: 0;
        }

        span.preheader {
            display: none;
            font-size: 1px;
        }

        html {
            width: 100%;
        }

        table {
            font-size: 14px;
            border: 0;
        }
        /* ----------- responsivity ----------- */

        @media only screen and (max-width: 640px) {
            /*------ top header ------ */
            .main-header {
                font-size: 20px !important;
            }

            .main-section-header {
                font-size: 28px !important;
            }

            .show {
                display: block !important;
            }

            .hide {
                display: none !important;
            }

            .align-center {
                text-align: center !important;
            }

            .no-bg {
                background: none !important;
            }
            /*----- main image -------*/
            .main-image img {
                width: 440px !important;
                height: auto !important;
            }
            /* ====== divider ====== */
            .divider img {
                width: 440px !important;
            }
            /*-------- container --------*/
            .container590 {
                width: 440px !important;
            }

            .container580 {
                width: 400px !important;
            }

            .main-button {
                width: 220px !important;
            }
            /*-------- secions ----------*/
            .section-img img {
                width: 320px !important;
                height: auto !important;
            }

            .team-img img {
                width: 100% !important;
                height: auto !important;
            }
        }

        @media only screen and (max-width: 479px) {
            /*------ top header ------ */
            .main-header {
                font-size: 18px !important;
            }

            .main-section-header {
                font-size: 26px !important;
            }
            /* ====== divider ====== */
            .divider img {
                width: 280px !important;
            }
            /*-------- container --------*/
            .container590 {
                width: 280px !important;
            }

            .container590 {
                width: 280px !important;
            }

            .container580 {
                width: 260px !important;
            }
            /*-------- secions ----------*/
            .section-img img {
                width: 280px !important;
                height: auto !important;
            }
        }
    </style>
    <!--[if gte mso 9]><style type=”text/css”>
        body {
        font-family: arial, sans-serif!important;
        }
        </style>
    <![endif]-->
</head>


<body class="respond" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
    <!-- header -->
    <table border="0" width="100%" cellpadding="0" cellspacing="0" bgcolor="ffffff">

        <tr>
            <td align="center">
                <table border="0" align="center" width="590" cellpadding="0" cellspacing="0" class="container590">

                    <tr>
                        <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td>
                    </tr>

                    <tr>
                        <td align="center">

                            <table border="0" align="center" width="590" cellpadding="0" cellspacing="0" class="container590">

                                <tr>
                                    <td align="center" style="height:70px;">
                                        <a href="" style="display: block; border-style: none !important; border: 0 !important;">
                                            <img 
                                                 width="280" 
                                                 height="100"
                                                 border="0" style="display: block;" 
                                                 alt="Syren Logo"
                                                 src="data:image/svg;base64,iVBORw0KGgoAAAANSUhEUgAAAFYAAAAhCAYAAABDcVyOAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAN4SURBVHgB7VrRcdswDGXu+l+PoG7gbqARvEHUCeINrE5gdQJ5A2cDZQNnA6YTKJ3glYzACoJIU7blxJfy3fFsggBBPoEQSVupmQBgYcrGlEIldDBkbNFho86AsctMeUaPXP3voEjj0JaoE+wzskEiVsAQUXnILSbY+Uhdq4QehpASY2yO6C89pBYqYYxABI5Sg13qprRMx35fqoQwiNxdKDWYz3tPWyJ1KgKpYR+L5oQJCKSGROocCKQGizJiUyG9zOLACbsGI29iOgkMmL5raITOVs0AdFu8At2uJFOfCYHU0PJlj+40J8k9nEsGup1IizFmeWA3hUBq2EZ09KnkUpTyB9hguGpK9dmACanBQ64lZ3WCj0fW74LJ3TG8pbp9ADZFLIW9k+eibsduV1bBbZisgGd/7voiPae74mObBdR5LDXIk5rFpJcaI7YVxC6InIzqbgxa2GuS16K+Y99LanvAGHvnl/w53Is5aVwj75tO155BbVm7L7qjOVL0a+1rdBGSCb2c6WXMp8OKZJrJXGpxEepQkV+n23j6c7YNkzXqGkB/r8txYO12YAfZjsiThj+fW9QYRrGLoDXVHVma6WgnE7ZuXLUYr8NC1HnQPEo/swBd3mo8E28wzLdZQC961Ui2lii+hN98MJ2Ky5gvTpaWMpI7HNBHYsPkOYbE5sy2nJVYdE/RF6Ua4rIbXf5qY3oeH+5lkQk5v0POmC7IzyJAgo4QqwWxrizfhVh00SOJaskJX2KhKK0w4U3KfGw9/gfECv2Nb7JHiHXyUsj5C/J6xB4hqsE4qs6KUtHHjtnWNImK9SuJk/k4RGAdsHvb0aCLfr4aM1yDWPS/wsJD1EroXhSlHr8afowu2DHcHcDTrgPEWj+HgJ81mxemEPtFTZucJc4uxUw0/TSluru7e2W6D+ajNIUT+GLKD6P3pE4E9f2NxpCb8tWUP9Tnjvsm/Sej+0JjfTH1Z9HlLxrbs8fPd+HntymPrI9XmrObk8MTa48Dx5f9cqLuyVF6LtCfqgaRdjNAv+x9L6fCo39xLp1p3Fr4z9RHA/3ZN4c/p40iD/5bLK/uO4zfrpg9jaf6cFKJnD3CaEKRh/ExViP9WaMD/D+7WNilvY7Y5h8ZpTcN9LnR7dP+1SfaW5v087cEI3JwZFMJlwH+m6NaJVwO9EfENuXKefAXMJhlWZn9quYAAAAASUVORK5CYII=" />
                                        </a>
                                    </td>
                                </tr>

                            </table>
                        </td>
                    </tr>

                    <tr>
                        <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td>
                    </tr>

                </table>
            </td>
        </tr>
    </table>
    <!-- end header -->
    <!-- big image section -->
    <table border="0" width="100%" cellpadding="0" cellspacing="0" bgcolor="ffffff" class="bg_color">

        <tr>
            <td align="center">
                <table border="0" align="center" width="590" cellpadding="0" cellspacing="0" class="container590">

                    <tr>
                        <td align="center" style="color: #343434; font-size: 14px; font-family: Quicksand, Calibri, sans-serif;"
                            class="main-header">
                            <!-- section text ======-->

                            <div style="line-height: 35px; text-align:left">

                                Hi <span style="color: #5caad2;">{{EMAIL}},</span>

                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td height="10" style="font-size: 10px; line-height: 10px;">
                            &nbsp;
                        </td>
                    </tr>

                    <tr>
                        <td align="center">
                            <table border="0" width="40" align="center" cellpadding="0" cellspacing="0" bgcolor="eeeeee">
                                <tr>
                                    <td height="2" style="font-size: 2px; line-height: 2px;">
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>

                    <tr>
                        <td height="20" style="font-size: 20px; line-height: 20px;">
                            &nbsp;
                        </td>
                    </tr>

                    <tr>
                        <td align="left">
                            <table border="0" width="590" align="center" cellpadding="0" cellspacing="0" class="container590">
                                <tr>
                                    <td align="left" style="font-size: 16px; font-family: 'Work Sans', Calibri, sans-serif; line-height: 24px;">
                                        <!-- section text ======-->

                                        <p style="line-height: 24px;margin-bottom:15px;">
                                            Thank you for registering on the <b>Syren medical platform</b>.
                                        </p>
                                        <p style="line-height: 24px; margin-bottom:20px;">
                                            Your email verification code is <b>{{CODE}}</b>.
                                        </p>
                                        <table border="0" align="left" width="180" cellpadding="0" cellspacing="0" style="margin-bottom:20px;">

                                           

                                            <tr>
                                                <td height="10" style="font-size: 10px; line-height: 10px;">
                                                    &nbsp;
                                                </td>
                                            </tr>

                                        </table>

                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>





                </table>

            </td>
        </tr>


    </table>
    <!-- contact section -->
    <table border="0" width="100%" cellpadding="0" cellspacing="0" bgcolor="ffffff" class="bg_color">
        <tr>
            <td align="center">
                <table border="0" align="center" width="590" cellpadding="0" cellspacing="0" class="container590 bg_color">

                    <tr>
                        <td align="center">
                            <table border="0" align="center" width="590" cellpadding="0" cellspacing="0" class="container590 bg_color">

                                <tr>
                                    <td>
                                        <table border="0" width="300" align="left" cellpadding="0" cellspacing="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;"
                                               class="container590">

                                            <tr>
                                                <!-- logo -->
                                                <td align="left">
                                                    &nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td height="25" style="font-size: 25px; line-height: 25px;">
                                                    &nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td align="left" style="color: #888888; font-size: 14px; font-family: 'Work Sans', Calibri, sans-serif; line-height: 23px;"
                                                    class="text_color">
                                                    <div style="color: #333333; font-size: 14px; font-family: 'Work Sans', Calibri, sans-serif; font-weight: 600; mso-line-height-rule: exactly; line-height: 23px;">

                                                        Email us: <br /> <a href="mailto:" style="color: #888888; font-size: 14px; font-family: 'Hind Siliguri', Calibri, Sans-serif; font-weight: 400;">info@syren.com.ng</a>

                                                    </div>
                                                </td>
                                            </tr>

                                        </table>

                                        <table border="0" width="2" align="left" cellpadding="0" cellspacing="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;"
                                               class="container590">
                                            <tr>
                                                <td width="2" height="10" style="font-size: 10px; line-height: 10px;"></td>
                                            </tr>
                                        </table>

                                        <table border="0" width="200" align="right" cellpadding="0" cellspacing="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;"
                                               class="container590">

                                            <tr>
                                                <td class="hide" height="45" style="font-size: 45px; line-height: 45px;">
                                                    &nbsp;
                                                </td>
                                            </tr>



                                            <tr>
                                                <td height="15" style="font-size: 15px; line-height: 15px;">
                                                    &nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <table border="0" align="right" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td>
                                                                <a href="https://twitter.com/syrenng" style="display: block; border-style: none !important; border: 0 !important;"><img width="24" border="0" style="display: block;" src="http://i.imgur.com/Qc3zTxn.png" alt=""></a>
                                                            </td>
                                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                            <td>
                                                                <a href="https://www.facebook.com/syrenng" style="display: block; border-style: none !important; border: 0 !important;"><img width="24" border="0" style="display: block;" src="http://i.imgur.com/RBRORq1.png" alt=""></a>
                                                            </td>
                                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>

                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>

                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr>
            <td height="60" style="font-size: 60px; line-height: 60px;">&nbsp;</td>
        </tr>

    </table>
    <!-- end section -->
    <!-- footer ====== -->
    <table border="0" width="100%" cellpadding="0" cellspacing="0" bgcolor="f4f4f4">

        <tr>
            <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td>
        </tr>

        <tr>
            <td align="center">

                <table border="0" align="center" width="590" cellpadding="0" cellspacing="0" class="container590">

                    <tr>
                        <td>
                            <table border="0" align="left" cellpadding="0" cellspacing="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;"
                                   class="container590">
                                <tr>
                                    <td align="left" style="color: #aaaaaa; font-size: 14px; font-family: 'Work Sans', Calibri, sans-serif; line-height: 24px;">
                                        <div style="line-height: 24px;">

                                            <span style="color: #333333;"> &copy; Powered by Syren.</span>

                                        </div>
                                    </td>
                                </tr>
                            </table>

                            <table border="0" align="left" width="5" cellpadding="0" cellspacing="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;"
                                   class="container590">
                                <tr>
                                    <td height="20" width="5" style="font-size: 20px; line-height: 20px;">&nbsp;</td>
                                </tr>
                            </table>

                            <table border="0" align="right" cellpadding="0" cellspacing="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;"
                                   class="container590">

                                <tr>
                                    <td align="center">
                                        <table align="center" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td align="center" style="height: 24px">
                                                    <a style="font-size: 14px; font-family: 'Work Sans', Calibri, sans-serif; line-height: 24px;color: #5caad2; text-decoration: none;font-weight:bold;"
                                                       href="{{UnsubscribeURL}}"></a>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                            </table>
                        </td>
                    </tr>

                </table>
            </td>
        </tr>

        <tr>
            <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td>
        </tr>

    </table>
    <!-- end footer ====== -->

</body>

</html>
    
''';
}

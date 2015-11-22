public static void send(String Send, String Email, String check) {
  final String fromEmail = "mileu.quod@gmail.com";
  final String password = "(write your own password)";
  final String toEmail = Send+'@'+Email;

  // 메일 내용
  String subject="Register at quod";
  String body;
  body ="Hi "+Send+"?\n\nThankyou for registering at quod.\nTo complete the registration, you have to activate your account first, by type the code below into the program.\nIf you did not register at quod, please ignore this mail, or contact us at mileu.quod@gmail.com.\n\n"+check+"\n\nThankyou :)";

  Properties props = new Properties();
  // SSL
  props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
  props.put("mail.smtp.socketFactory.port", "465"); //SSL Port
  props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); //SSL Factory Class
  props.put("mail.smtp.auth", "true"); //Enabling SMTP Authentication
  props.put("mail.smtp.port", "465"); //SMTP Port


  // 인증
  Authenticator auth = new Authenticator() {
    protected PasswordAuthentication getPasswordAuthentication() {
      return new PasswordAuthentication(fromEmail, password);
    }
  };

  // 메일 세션
  Session session = Session.getInstance(props, auth);

  MimeMessage msg = new MimeMessage(session);
  //set message headers
  try {
    msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
    msg.addHeader("format", "flowed");
    msg.addHeader("Content-Transfer-Encoding", "8bit");

    msg.setFrom(new InternetAddress(fromEmail, "관리자"));
    msg.setReplyTo(InternetAddress.parse("no_reply@goodcodes.co.kr", false));

    msg.setSubject(subject, "UTF-8");
    msg.setText(body, "UTF-8");
    msg.setSentDate(new Date());

    msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
    Transport.send(msg);
  }  
  catch (MessagingException e) 
  {
    throw new RuntimeException(e);
  }  
  catch (UnsupportedEncodingException e) 
  {
    throw new RuntimeException(e);
  }
}
package ezen.mail;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
public class SendMail 
{
    private String from;  // 보내는 사람 메일주소
    private String to;    // 받는 사람 메일주소
    private String title; // 메일 제목
    private String body;  // 메일 내용
    private String id;    // 계정 아이디
    private String pw;    // 계정 비밀번호
    
    // 게터/세터 메소드
    public void setTo(String to)     { this.to = to;     }; // 수신자 설정
    public void setFrom(String from) { this.from = from; }; // 발신자 설정
    public void setMail(String title,String body) // 메일 내용 설정
    {
        this.title = title; // 제목 설정
        this.body  = body;  // 본문 설정
    }
    public void setAccount(String id,String pw) // 계정 정보 설정
    {
        this.id = id; // 계정 ID 설정
        this.pw = pw; // 계정 비밀번호 설정
    }
    
    
    // max자리의 인증코드를 생성하는 메소드
    public String AuthCode(int max)
    {
        String datas = "01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ"; // 인증코드 구성 문자 집합
        String code = ""; // 생성될 코드 초기화
        for(int i = 0 ; i < max; i++) // 지정된 자릿수만큼 반복
        {
            int rand = (int)(Math.random() * 100); // 0~99 사이의 난수 생성
            rand = rand % datas.length(); // 문자열 길이로 나눠 인덱스 범위 내 값으로 변환
            code += datas.charAt(rand); // 해당 인덱스의 문자를 코드에 추가
        }
        return code; // 생성된 인증코드 반환
    }
    
    // 메일을 발송하는 메소드
    public boolean sendMail()
    {
        try
        {
            System.out.println("메일 발송을 시작합니다.");
            
            Properties clsProp = System.getProperties(); // 시스템 속성 가져오기
            
            // 메일 서버 설정
            // 메일 서버 주소 (네이버 SMTP 서버)
            clsProp.put("mail.smtp.host", "smtp.naver.com");
            
            // 메일 서버 포트 번호 (SSL 포트)
            clsProp.put("mail.smtp.port", 465);
            
            // 네이버 로그인 인증 설정
            clsProp.put("mail.smtp.auth", "true"); // 인증 필요
            clsProp.put("mail.smtp.ssl.enable", "true"); // SSL 사용
            clsProp.put("mail.smtp.ssl.trust", "smtp.naver.com"); // 신뢰할 호스트
            clsProp.put("mail.smtp.ssl.protocols", "TLSv1.2"); // SSL 프로토콜 버전
            
            // 세션 생성 및 인증 처리
            Session clsSession = Session.getInstance(clsProp, new Authenticator()
            {
                public PasswordAuthentication getPasswordAuthentication()
                {
                    // 인증 아이디/비밀번호를 반환
                    return new PasswordAuthentication(id, pw);
                }
            });
            
            // 메시지 객체 생성
            Message clsMessage = new MimeMessage(clsSession);
            
            // 발신자 이메일 주소 설정
            clsMessage.setFrom(new InternetAddress(from));
            
            // 수신자 이메일 주소 설정
            clsMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            
            // 제목 설정
            clsMessage.setSubject(title);
            
            // 메일 내용 설정 (HTML 형식, EUC-KR 인코딩)
            clsMessage.setContent(body, "text/html;charset=euckr");
            
            // 메일 전송
            Transport.send(clsMessage);
            
            System.out.println("메일 발송을 종료합니다.");
            
            return true; // 발송 성공
        }
        catch(Exception e)
        {
            e.printStackTrace(); // 오류 출력
            System.out.println("메일 발송을 종료합니다.");
            return false; // 발송 실패
        }
    }
    
    // 테스트용 메인 메소드
    public static void main(String[] args)
    {
        SendMail mail = new SendMail(); // 메일 객체 생성
        //System.out.println(mail.AuthCode(7)); // 7자리 인증코드 생성 테스트
        mail.setFrom("id@naver.com"); // 발신자 설정
        mail.setTo("id@naver.com"); // 수신자 설정
        mail.setAccount("id", "pw"); // 계정 정보 설정
        mail.setMail("안녕하세요 EZENGREEN입니다.", "회원님의 인증코드는 " + mail.AuthCode(6) + "입니다.");
        // 제목, 본문 설정 (6자리 인증코드 포함)
        mail.sendMail(); // 메일 발송
    }
}
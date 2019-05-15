package udp;
import java.net.*;
import java.io.*;

public class Rfc865UdpClient {
	public static void main(String[] args) {
		//1. Open UDP Socket
		DatagramSocket socket = null;
		try{
			socket = new DatagramSocket();
			InetAddress IpAddress = InetAddress.getByName("hw1-b00");
			socket.connect(IpAddress, 17);

		}catch(SocketException e){
			e.printStackTrace();
			System.exit(-1);
		} catch (UnknownHostException e) {
			e.printStackTrace();
			System.exit(-1);
		}

		try {
			//2. Send UDP request to server
			byte[] buf = "LEE SUYEON, TE1, <179.21.149.21>".getBytes("UTF-8");
			DatagramPacket request = new DatagramPacket(buf, buf.length);
			socket.send(request);

			//3. Receive UDP reply from server
			byte[] replyBuf = new byte[512];
			DatagramPacket reply = new DatagramPacket(replyBuf, replyBuf.length);
			socket.receive(reply);

			String quote = new String(replyBuf);
			System.out.println(quote);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			socket.close();
		}
	}
}

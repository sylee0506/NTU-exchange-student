/**
 * @(#)Rfc86UdpServer.java
 *
 * Rfc86UdpServer application
 *
 * @author
 * @version 1.00 2019/3/15
 */
package udp;
import java.net.*;
import java.io.*;

public class Rfc86UdpServer {

    public static void main(String[] args) {
    	//
 		// 1. Open UDP socket at well-known port
 		//
 		//static DatagramSocket socket;
 		DatagramSocket socket = new DatagramSocket();
 		try {
 			socket = new DatagramSocket(17);
 		} catch (SocketException e) {
 			System.out.println("Socket error! " + e.getMessage());}

 		while (true) {
 			try {
				//
 				// 2. Listen for UDP request from client
				//
				byte[] buffer = new byte[512];
 				DatagramPacket request = new DatagramPacket(buffer, buffer.length);
 				socket.receive(request);
 				System.out.println("Received Request");

 				String clientRequest = new String(buffer,0,request.getLength());
 				System.out.println("Data : " + clientRequest);

 				InetAddress clientAddr = request.getAddress();
 				int clientPort = request.getPort();
 				System.out.println("clientAddr : " + clientAddr);
 				//
 				// 3. Send UDP reply to client
 				//
 				byte[] replybuffer = "Hello world!".getBytes();
 				DatagramPacket reply = new DatagramPacket(replybuffer, replybuffer.length, clientAddr, clientPort);
 				socket.send(reply);
				System.out.println("Sent Reply");

 			} catch (IOException e) {
 				System.out.println("Request / Reply error! " + e.getMessage());}
 		}
    }
}

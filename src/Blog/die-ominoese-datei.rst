Die ominoese Datei
##################
:date: 2011-10-25 12:45
:tags: java, pastebin, wtf

Erst einmal: Entschuldigung fuer die Woche...ich hatte einige Probleme
zuhause und deswegen war alles offline. Nun zu dem, was sich die Woche
angestaut hat. Ich hab fleissig weitergescannt und bin ueber einen
netten Eintrag gestolpert, den ich eigentlich sehr cool fand. Um es
gleich Vorweg zu nehmen: Es existieren davon noch einige mehr, aber das
war eigentlich der netteste :)

::

    UEsDBBQAAgAIABVoUz8z7a9qJQEAACoCAAARABwAVENQQ2xpZW50QXBwLmphdmFVVAkAA9mtnk7d
    rZ5OdXgLAAEEeEEAAAQBAgAAbZBBSwMxEIXP3V8x7CkVCXouHkQ8W9iCB/UQ03E3NpsJyWxrkf53
    s5uwbcEQCHmZ972ZmN5TYPhWeyUdsrxZVeZCMjQqlR8+rdGgrYoRNk/rJ2vQ8aP38FstymNkxenY
    k9lCr4wTDQfj2rcPUKGNy7FycWX1gVp4AIeHK6RYrlIlh+PkGItkQgfO+gm0Yt2J5x+Nng05wIxe
    oPQpjxtWercJSmMxVOOeu5zaKzzgLtAhwpk1gppjZOwlDZyB1ok6N5d9uJVS1hO7Ib3DJGPYYyij
    ZE3UlrSyHUWub+H+Lq3s+A9OzqFOXGAqrDlhPRa9BsOJn0wl40IVxdAivwzshzR/QNWL5WSfc0R9
    HLw3+O7q+eHLDrET81VbiuXPCvOsnKpT9QdQSwMEFAACAAgAJmdTP/8HGntGAQAAxQIAABEAHABU
    Q1BTZXJ2ZXJBcHAuamF2YVVUCQADB62eTgytnk51eAsAAQR4QQAABAECAAB1kT9PwzAQxefmU1id
    HAYL5ooBEAMSAyLdEIPrXFPTxLbOl5YK9bvjf2qToVGkKO/ufu+drQdnkdiPPEhhgMTdqtITSduo
    VG7c9Fox1Uvv2frlowE8AD45x/6qRSl6khQ+B6tbNkhteEOoTff1zSR2vo6di9moQ9uxR2bgOEPy
    ehU6CU9pIjaJgEbK+pkpSWrHX38VONLWMMjoBQgX/KghqfZrlArKQBXfS8oUr/AY7dAePbuyIqg5
    eYJB2JEysDd8mcPlOWiFEMvEznJj1R6I+elPXmta5w/34cljtx16HUomHBsLadI1pLGrY8arXoOJ
    LlNTIVXcg9/0eLHGgEqLbtEOhXJhP4/bLSC0nyDbEGWDZYu5zqP0ZtwYThpBDkUtrA5oUuN1fSvM
    BkXoaN+1CfeUmoKieuvLtRXeRJmtetXP1bn6B1BLAQIeAxQAAgAIABVoUz8z7a9qJQEAACoCAAAR
    ABgAAAAAAAEAAACkgQAAAABUQ1BDbGllbnRBcHAuamF2YVVUBQAD2a2eTnV4CwABBHhBAAAEAQIA
    AFBLAQIeAxQAAgAIACZnUz//Bxp7RgEAAMUCAAARABgAAAAAAAEAAACkgXABAABUQ1BTZXJ2ZXJB
    cHAuamF2YVVUBQADB62eTnV4CwABBHhBAAAEAQIAAFBLBQYAAAAAAgACAK4AAAABAwAAAAA=

Das fand ich in einer Datei abgespeichert bei mir. Natuerlich handelt es
sich um etwas base64 codiertes. Wenn man das decodiert und ueberprueft
sieht man, dass es eine ZIP Datei ist:

::

    15:43:56 seda:~/dev/pastebin/
    % base64 -d -i data/A9jtH7Lm > output
    15:44:12 seda:~/dev/pastebin/
    % file output 
    output: Zip archive data, at least v2.0 to extract
    15:45:03 seda:~/dev/pastebin/
    % unzip output 
    Archive:  output
      inflating: TCPClientApp.java       
      inflating: TCPServerApp.java 

In dieser ZIP Datei sind 2 Java Source Codes. Die sind nicht sonderlich
spannend, aber ich hab sie der vollstaendigkeithalber lieber mal
drangehaengt: **TCPClient.java**

::

    import java.net.*;
    import java.io.*;

    public class TCPClientApp {
        public static void main(String[] args) {
            TCPClientApp prog = new TCPClientApp();
            try {
            prog.start();
            } catch(Exception e) {
                e.printStackTrace();
            }
        }
        
        public void start() throws Exception {
            System.out.println("Client started...");
            Socket server = new Socket("localhost", 10000);
            System.out.println("Connected to server...");
            PrintWriter out = new PrintWriter(server.getOutputStream());
            out.print("yuppie\n");
            out.flush();
            out.close();
            server.close();
        }
    }

**TCPServer.java**

::

    import java.net.*;
    import java.io.*;

    public class TCPServerApp {
        public static void main(String[] args) {
            TCPServerApp prog = new TCPServerApp();
            try {
            prog.start();
            } catch(Exception e) {
                e.printStackTrace();
            }
        }
        
        public void start() throws Exception {
            System.out.println("Server started...");
            ServerSocket serverSocket = new ServerSocket(10000);
            System.out.println("Server listening on port 10000...");
            Socket client = serverSocket.accept();
            System.out.println("Connection from client...");
            BufferedReader br = new BufferedReader(new InputStreamReader(client.getInputStream()));
            System.out.println(br.readLine());
            br.close();
            client.close();
            serverSocket.close();
        }
    }

Da sieht man mal wieder, dass man pastebin.com auch super nutzen kann um
Dateien zu sharen. Es ist sogar ein One-Click-Hoster, wenn man die
Dateien klein genug macht :) Es existieren noch ganz viele Bilder und
andere kleine Dateien, auf die ich aber nicht eingehen moechte. so long

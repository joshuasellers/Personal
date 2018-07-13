/**
 * Created by joshuasellers on 7/11/18.
 */
public class RNMain {

    private static Integer getInt(String numeral){
        char[] digitsRN = numeral.toCharArray();
        int[] digitsActual = new int[digitsRN.length];
        for (int i = 0; i < digitsRN.length; i++){
            switch (digitsRN[i]){
                case 'I':
                    System.out.println('I');
                    digitsActual[i] = 1;
                    break;
                case 'V':
                    System.out.println('V');
                    digitsActual[i] = 5;
                    break;
                case 'X':
                    System.out.println('X');
                    digitsActual[i] = 10;
                    break;
                case 'L':
                    System.out.println('L');
                    digitsActual[i] = 50;
                    break;
                case 'C':
                    System.out.println('C');
                    digitsActual[i] = 100;
                    break;
                case 'D':
                    System.out.println('D');
                    digitsActual[i] = 500;
                    break;
                case 'M':
                    System.out.println('M');
                    digitsActual[i] = 1000;
                    break;
                default:
                    System.out.println("Invalid Numeral");
                    System.exit(0);
            }
        }
        int number = 0;
        for (int i = 0; i < digitsActual.length; i++){
            if (i+1 == digitsActual.length){
                number += digitsActual[i];
            }
            else{
                if (digitsActual[i+1] > digitsActual[i]) number -= digitsActual[i];
                else number += digitsActual[i];
            }
        }
        return number;
    }

    private static String getNumeral(int output){
        String final_answer = "";
        while (output > 0) {
            if (output >= 1000) {
                final_answer += 'M';
                output -= 1000;
            }
            else if (500 <= output && output < 1000){
                final_answer += 'D';
                output -= 500;
            }
            else if (100 <= output && output < 500){
                final_answer += 'C';
                output -= 100;
            }
            else if (50 <= output && output < 100){
                final_answer += 'L';
                output -= 50;
            }
            else if (10 <= output && output < 50){
                final_answer += 'X';
                output -= 10;
            }
            else if (5 <= output && output < 10){
                final_answer += 'V';
                output -= 5;
            }
            else{
                final_answer += 'I';
                output -= 1;
            }
        }
        return final_answer;
    }

    private static String mathRN(String first, String operation, String second){
        int f = getInt(first);
        int s = getInt(second);
        String out = "";
        switch (operation){
            case "x":
                out = getNumeral(f*s);
                break;
            case "+":
                out = getNumeral(f+s);
                break;
            case "-":
                out = getNumeral(f-s);
                break;
            case "/":
                out = getNumeral(f/s);
                break;
            default:
                System.out.println("Invalid Operation");
                System.exit(0);
        }
        return out;
    }


    public static void main(String[] args) {
        if (args.length != 3){
            System.out.println("Invalid Number of ARGs");
            System.exit(0);
        }
        else {
            String first = args[0];
            String operation = args[1];
            String second = args[2];
            System.out.println(first +" "+ operation +" "+ second +" = "+mathRN(first,operation,second));
        }
    }
}

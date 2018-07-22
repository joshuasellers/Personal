/**
 * Created by joshuasellers on 7/11/18.
 */
public class RNCalc {
    private String first;
    private String second;
    private String operation;


    private static Integer getInt(String numeral){
        char[] digitsRN = numeral.toCharArray();
        int[] digitsActual = new int[digitsRN.length];
        for (int i = 0; i < digitsRN.length; i++){
            switch (digitsRN[i]){
                case 'I':
                    digitsActual[i] = 1;
                    break;
                case 'V':
                    digitsActual[i] = 5;
                    break;
                case 'X':
                    digitsActual[i] = 10;
                    break;
                case 'L':
                    digitsActual[i] = 50;
                    break;
                case 'C':
                    digitsActual[i] = 100;
                    break;
                case 'D':
                    digitsActual[i] = 500;
                    break;
                case 'M':
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
        return checkRules(final_answer);
    }

    private static String checkRules(String final_answer){
        char[] digitsRN = final_answer.toCharArray();
        String correct = "";
        String holder = "";
        for (int i = 0; i < digitsRN.length; i++){
            holder += digitsRN[i];
            int x = getInt(holder);
            if (holder.length() == 5) {
                switch (x) {
                    case 4:
                        correct += "IV";
                        holder = "";
                        break;
                    case 9:
                        correct += "IX";
                        holder = "";
                        break;
                    case 40:
                        correct += "XL";
                        holder = "";
                        break;
                    case 90:
                        correct += "XC";
                        holder = "";
                        break;
                    case 400:
                        correct += "CD";
                        holder = "";
                        break;
                    case 900:
                        correct += "CM";
                        holder = "";
                        break;
                    default:
                        correct += holder;
                        holder = "";
                }
            }
        }
        return (correct + holder);
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


    public RNCalc(String first, String second, String operation) {
        this.first = first;
        this.second = second;
        this.operation = operation;
    }

    public String getOutput(){
        return this.first +" "+ this.operation +" "+ this.second +" = "+mathRN(this.first,this.operation,this.second);
    }
}

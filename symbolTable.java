
import java.util.HashMap;

public class symbolTable {

    public HashMap<String, symbol> h = new HashMap<>();
    private int totalSize = 0;

    public void addSymbol(symbol s) {
        h.put(s.name, s);
        totalSize += s.width;
        //stack.;

    }
    
    public void print(){
        for (String s  : h.keySet()) {
            symbol sy = h.get(s);
            System.out.println("name: " + sy.name + "- type: " + sy.type + "- width: " + sy.width + "- isConst: " + sy.isConst);
            
        }
 

    }

    public int getTotalSize() {
        return totalSize;
    }

//    public Object getValue(String name) {
//        for (String s : h.keySet()) {
//            if (name.equals(s)) {
//                return h.get(s).value;
//            }
//        }
//        return null;
//    }

    public boolean isDefined(String name) {
        for (String s : h.keySet()) {
            if (name.equals(s)) {
                return true;
            }
        }
        return false;
    }

    public String getType(String name) {
        for (String s : h.keySet()) {
            if (name.equals(s)) {
                return h.get(s).type;
            }
        }
        return "not defined";
    }
    
    public boolean isConstSymbol(String name){
        for (String s : h.keySet()) {
            if (name.equals(s)) {
                return h.get(s).isConst;
            }
        }
        return false;
    }

//    public boolean updateSymbol(String name, Object value) {
//        for (String s : h.keySet()) {
//            if (name.equals(h.get(s))) {
//                String type1 = h.get(s).type;
//                String type2 = value.getClass().getName();
//                if (type1 == "int" && type2 == "java.lang.Integer") {
//                    h.get(s).type = (int) value;
//                    return true;
//                } else if (type1 == "double" && type2 == "java.lang.Double") {
//                    h.get(s).value = (double) value;
//                    return true;
//                } else if (type1 == "float" && type2 == "java.lang.Float") {
//                    h.get(s).value = (float) value;
//                    return true;
//                } else if (type1 == "char" && type2 == "java.lang.Character") {
//                    h.get(s).value = (char) value;
//                    return true;
//                } else if (type1 == "long" && type2 == "java.lang.Long") {
//                    h.get(s).value = (long) value;
//                    return true;
//                } else if (type1 == "boolean" && type2 == "java.lang.Boolean") {
//                    h.get(s).value = (boolean) value;
//                    return true;
//                } else if (type1 == "String" && type2 == "java.lang.String") {
//                    h.get(s).value = (String) value;
//                    return true;
//                } else if (type1 == "int" && type2 == "java.lang.Character") {
//                    h.get(s).value = (int) ((char) value);
//                    return true;
//                } else if (type1 == "char" && type2 == "java.lang.Boolean") {
//                    char a = (boolean) value ? '\01' : '\0';
//                    h.get(s).value = a;
//                    return true;
//                } else if (type1 == "int" && type2 == "java.lang.Boolean") {
//                    int a = (boolean) value ? 1 : 0;
//                    h.get(s).value = a;
//                    return true;
//                } else if (type1 == "boolean" && type2 == "java.lang.Long") {
//                    boolean a = !((long) value == 0);
//                    h.get(s).value = a;
//                    return true;
//                } else if (type1 == "long" && type2 == "java.lang.Integer") {
//                    h.get(s).value = (long) value;
//                    return true;
//                } else if (type1 == "double" && type2 == "java.lang.Integer") {
//                    h.get(s).value = (double) value;
//                    return true;
//                } else {
//                    return false;
//                }
//            }
//        }
//        return false;
//    }
}


public class symbol {
    public String name;
    public String type;
//    public Object value;
    public boolean isConst;
    public int width;
    
    public symbol(String name, String type, int width, boolean isConst){
        this.name = name;
        this.type = type;
//        this.value = value;
        this.width = width;
        this.isConst = isConst;
    }
}


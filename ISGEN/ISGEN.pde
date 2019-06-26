Button selectCtrl;
Button selectAsmg;
Button selectOut;
Button compile;
String ctrlPath = "";
String asmgPath = "";
String outPath = "";
String error = "";

void setup() {
  size(600, 200);
  String[] s = loadStrings("data/paths.txt");
  if (s != null && s.length == 3) {
    ctrlPath = s[0];
    asmgPath = s[1];
    outPath = s[2];
  }
  selectCtrl = new Button(100, 5, 50, 20, "select", false, new Runnable() {
    public void run() {
      selectInput("select control signal file...", "selCtrl");
    }
  });
  selectAsmg = new Button(100, 35, 50, 20, "select", false, new Runnable() {
    public void run() {
      selectInput("select assembly guide file...", "selAsmg");
    }
  });
  selectOut = new Button(100, 65, 50, 20, "select", false, new Runnable() {
    public void run() {
      selectOutput("select output name...", "selOut");
    }
  });
  compile = new Button(5, 95, 60, 20, "compile", false, new Runnable() {
    public void run() {
      if (loadStrings(asmgPath) == null) {
        error = "missing assembly guide";
        return;
      }
      if (loadStrings(ctrlPath) == null) {
        error = "missing assembly guide";
        return;
      }
      compile();
      String[] s = {
          ctrlPath,
          asmgPath,
          outPath
      };
      saveStrings("data/paths.txt", s);
    }
  });
}

void draw() {
  background(255);
  selectAsmg.render();
  selectCtrl.render();
  selectOut.render();
  compile.render();
  textAlign(CORNER);
  fill(0);
  text("control signal", 5, 20);
  text("assembly guide", 5, 50);
  text("output name", 5, 80);
  text(ctrlPath, 160, 20);
  text(asmgPath, 160, 50);
  text(outPath, 160, 80);
  fill(#ff0000);
  text(error, 70, 110);
}

void compile() {
  error = "";
  String[] ctrl = loadStrings(ctrlPath);
  String[] asmg = loadStrings(asmgPath);
  int[] inst = new int[256];
  for (int i = 0; i < asmg.length; i++) {
    if (asmg[i].charAt(0) == '@') {
      
    }
    else
    {
      String[] split = split(asmg[i], " ");
      byte address = byte(unhex(split[0]));
      split = split(split[split.length - 1], ";");
      if (split.length > 4) {
        error = hex(address, 2) + ": instruction too complex";
        return;
      }
      for (int l = 0; l < split.length; l++) {
        inst[(address << 2) | l] = getCtrl(split(split[l], ":"), ctrl);
      }
    }
  }
  for (int i = 0; i < 32; i ++) {
    print(hex(i * 8, 2) + ":");
    for (int l = 0; l < 8; l++) {
      print(" " + hex(inst[i * 8 + l]));
    }
    println();
  }
  saveLHF(inst);
  saveMDT16(inst);
  saveMDT8(inst);
  saveDAT(inst);
}

void saveMDT8(int[] inst) {
  byte[] data = new byte[1024];
  for (int i = 0; i < 256; i++) {
    data[i] = byte(inst[i] & 0xff);
    data[i | 0x100] = byte((inst[i] >> 8) & 0xff);
    data[i | 0x200] = byte((inst[i] >> 16) & 0xff);
    data[i | 0x300] = byte((inst[i] >> 24) & 0xff);
    if (i < 0xf) {
      println(hex(i) + ": $" + hex(byte(inst[i] & 0xff), 2));
      println(hex(i | 0x100) + ": $" + hex(byte((inst[i] >> 8) & 0xff), 2));
      println(hex(i | 0x200) + ": $" + hex(byte((inst[i] >> 16) & 0xff), 2));
      println(hex(i | 0x300) + ": $" + hex(byte((inst[i] >> 24) & 0xff), 2));
    }
  }
  saveBytes(outPath + "_MDT8.dat", data);
}

void saveMDT16(int[] inst) {
  saveMDT16(inst, 0);
  saveMDT16(inst, 1);
}

void saveMDT16(int[] inst, int ht) {
  byte[] data = new byte[512];
  for (int i = 0; i < 256; i++) {
    data[i] = byte((inst[i] >> (8 * ht)) & 0xff);
    data[i | 0x100] = byte((inst[i] >> (8 * ht + 16)) & 0xff);
  }
  saveBytes(outPath + "_MDT16_" + ht + ".dat", data);
}

void saveDAT(int[] inst) {
  saveDAT(inst, 0);
  saveDAT(inst, 1);
  saveDAT(inst, 2);
  saveDAT(inst, 3);
}

void saveDAT(int[] inst, int ht) {
  byte[] b = new byte[256];
  for (int i = 0; i < 256; i++) {
    b[i] = byte((inst[i] >> (ht * 8)) & 0xff);
  }
  saveBytes(outPath + ht + ".dat", b);
}

void saveLHF(int[] inst) {
  String s = "";
  for (int i = 0; i < inst.length; i++) {
    s += hex(inst[i]);
    if (i < inst.length - 1) {
      s += " ";
    }
  }
  saveStrings(outPath + ".hex", new String[]{"v2.0 raw", s});
}

int getCtrl(String[] s, String[] ctrl) {
  int out = 0;
  if (s.length == 0) {
    error = "unneccesary stage";
  }
  for (int i = 0; i < s.length; i++) {
    boolean found = false;
    for (int l = 0; l < ctrl.length; l ++) {
      String bit = split(ctrl[l], " ")[0];
      if (bit != "-" && bit.length() > 0) {
        if (s[i].equalsIgnoreCase(bit)) {
          out = out | (1 << l);
          found = true;
        }
      }
    }
    if (!found) {
      error = "Control signal \"" + s[i] + "\" not found!";
    }
  }
  return out;
}

void selCtrl(File selected) {
  if (selected != null && selected.exists()) {
    ctrlPath = selected.getAbsolutePath();
  }
  mousePressed = false;
}

void selAsmg(File selected) {
  if (selected != null && selected.exists()) {
    asmgPath = selected.getAbsolutePath();
  }
  mousePressed = false;
}

void selOut(File selected) {
  if (selected != null) {
    outPath = selected.getAbsolutePath();
  }
  mousePressed = false;
}

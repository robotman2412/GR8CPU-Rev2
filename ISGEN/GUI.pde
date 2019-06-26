

/**
 * @author Julian Scheffers
**/

/*
 * GUI, Copyright (©) Julian Scheffers, all rights reserved.
 */



int sketchWidth;
int sketchHeight;

interface SidedRunnable {
  public void pre();
  public void post();
}

interface AdvRunnable {
  public Object run(Object in);
}

AdvRunnable advRunnable(final Runnable S_simple) {
  return new AdvRunnable(){
    Runnable simple = S_simple;
    public Object run(Object o) {
      simple.run();
      return null;
    }
  };
}

class Style {
  color fill;
  color stroke;
  float strokeWeight;
  Style(color S_fill, color S_stroke, float S_strokeWeight) {
    fill = S_fill;
    stroke = S_stroke;
    strokeWeight = S_strokeWeight;
  }
  PGraphics _set(PGraphics graphics) {
    graphics.fill(fill);
    graphics.stroke(stroke);
    graphics.strokeWeight(strokeWeight);
    return graphics;
  }
  void _set() {
    fill(fill);
    stroke(stroke);
    strokeWeight(strokeWeight);
  }
  void _rect(float x, float y, float width, float height) {
    fill(fill);
    stroke(stroke);
    strokeWeight(strokeWeight);
    rect(x, y, width, height);
  }
  void _ellipse(float x, float y, float width, float height) {
    fill(fill);
    stroke(stroke);
    strokeWeight(strokeWeight);
    ellipse(x, y, width, height);
  }
  void _line(float bx, float by, float ex, float ey) {
    fill(fill);
    stroke(stroke);
    strokeWeight(strokeWeight);
    line(bx, by, ex, ey);
  }
  void _rect(float x, float y, float width, float height, PGraphics graphics) {
    graphics.fill(fill);
    graphics.stroke(stroke);
    graphics.strokeWeight(strokeWeight);
    graphics.rect(x, y, width, height);
  }
  void _ellipse(float x, float y, float width, float height, PGraphics graphics) {
    graphics.fill(fill);
    graphics.stroke(stroke);
    graphics.strokeWeight(strokeWeight);
    graphics.ellipse(x, y, width, height);
  }
  void _line(float bx, float by, float ex, float ey, PGraphics graphics) {
    graphics.fill(fill);
    graphics.stroke(stroke);
    graphics.strokeWeight(strokeWeight);
    graphics.line(bx, by, ex, ey);
  }
}

class TextStyle {
  color col;
  float size;
  int align;
  TextStyle(color S_col, float S_size, int S_align) {
    col = S_col;
    size = S_size;
    align = S_align;
  }
  TextStyle(color S_col) {
    col = S_col;
    size = 12;
    align = CORNER;
  }
  void _set() {
    fill(col);
    textSize(size);
    textAlign(align);
  }
  void _set(PGraphics graphics) {
    graphics.fill(col);
    graphics.textSize(size);
    graphics.textAlign(align);
  }
  void _text(String text, float x, float y) {
    fill(col);
    textSize(size);
    textAlign(align);
    text(text, x, y);
  }
  void _text(String text, float x, float y, PGraphics graphics) {
    graphics.fill(col);
    graphics.textSize(size);
    graphics.textAlign(align);
    graphics.text(text, x, y);
  }
}

class Text {
  float x;
  float y;
  String text;
  TextStyle style;
  Text(float S_x, float S_y, String S_text, TextStyle S_style) {
    x = S_x;
    y = S_y;
    text = S_text;
    style = S_style;
  }
  Text(float S_x, float S_y, String S_text) {
    x = S_x;
    y = S_y;
    text = S_text;
    style = new TextStyle(0);
  }
  void display() {
    style._text(text, x, y);
  }
  void display(PGraphics p) {
    style._text(text, x, y, p);
  }
}

class CheckboxStyle {
  Style check;
  Style cross;
  Style box;
  Style disabled;
  CheckboxStyle() {
    check = new Style(255, #00ff00, 1);
    cross = new Style(255, #ff0000, 1);
    box = new Style(255, 127, 1);
    disabled = new Style(255, 192, 1);
  }
  CheckboxStyle(Style S_check, Style S_cross, Style S_box, Style S_disabled) {
    check = S_check;
    cross = S_cross;
    box = S_box;
    disabled = S_disabled;
  }
}

class Checkbox {
  int x;
  int y;
  int width;
  int height;
  boolean value;
  boolean enabled;
  CheckboxStyle style;
  Runnable onChange;
  Checkbox(int S_x, int S_y, int S_width, int S_height) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    value = false;
    enabled = true;
    style = new CheckboxStyle();
    onChange = null;
  }
  Checkbox(int S_x, int S_y, int S_width, int S_height, CheckboxStyle S_style) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    value = false;
    enabled = true;
    style = S_style;
    onChange = null;
  }
  Checkbox(int S_x, int S_y, int S_width, int S_height, Runnable S_onChange) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    value = false;
    enabled = true;
    style = new CheckboxStyle();
    onChange = S_onChange;
  }
  Checkbox(int S_x, int S_y, int S_width, int S_height, CheckboxStyle S_style, Runnable S_onChange) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    value = false;
    enabled = true;
    style = S_style;
    onChange = S_onChange;
  }
  void display() {
    if (enabled) {
      if (value) {
        style.box._set();
        rect(x, y, width, height);
        style.check._set();
        line(x, y + height / 2, x + width / 2, y + height);
        line(x + width / 2, y + height, x + width, y);
      }
      else
      {
        style.box._set();
        rect(x, y, width, height);
        style.cross._set();
        line(x, y, x + width, y + height);
        line(x + width, y, x, y + height);
      }
    }
    else
    {
      style.disabled._set();
      rect(x, y, width, height);
      if (value) {
        line(x, y + height / 2, x + width / 2, y + height);
        line(x + width / 2, y + height, x + width, y);
      }
      else
      {
        line(x, y, x + width, y + height);
        line(x + width, y, x, y + height);
      }
    }
  }
  //do render in mousePressed
  void render() {
    if (enabled && mouseX >= x && mouseX < x + width && mouseY >= y && mouseY < y + height) value = !value;
  }
}

class DropdownStyle {
  TextStyle text;
  TextStyle textDisabled;
  Style normal;
  Style disabled;
  color selected;
  color hover;
  DropdownStyle() {
    text = new TextStyle(0);
    textDisabled = new TextStyle(192);
    normal = new Style(255, 127, 1);
    disabled = new Style(255, 192, 1);
    selected = 192;
    hover = #60afff;
  }
  DropdownStyle(TextStyle S_text, TextStyle S_textDisabled, Style S_normal, Style S_disabled) {
    text = S_text;
    textDisabled = S_textDisabled;
    normal = S_normal;
    disabled = S_disabled;
  }
}

class DropdownElement {
  String id;
  String value;
  DropdownElement(String S_id, String S_value) {
    id = S_id;
    value = S_value;
  }
}

class Dropdown {
  int x;
  int y;
  int width;
  int height;
  int selectedIndex;
  boolean open;
  boolean enabled;
  DropdownElement[] elements;
  DropdownStyle style;
  SidedRunnable onChange;
  Dropdown(int S_x, int S_y, int S_width, int S_height, DropdownElement[] S_elements) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    selectedIndex = 0;
    open = false;
    enabled = true;
    elements = S_elements;
    style = new DropdownStyle();
    onChange = null;
  }
  Dropdown(int S_x, int S_y, int S_width, int S_height, DropdownElement[] S_elements, DropdownStyle S_style) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    selectedIndex = 0;
    open = false;
    enabled = true;
    elements = S_elements;
    style = S_style;
    onChange = null;
  }
  Dropdown(int S_x, int S_y, int S_width, int S_height, DropdownElement[] S_elements, SidedRunnable S_onChange) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    selectedIndex = 0;
    open = false;
    enabled = true;
    elements = S_elements;
    style = new DropdownStyle();
    onChange = S_onChange;
  }
  Dropdown(int S_x, int S_y, int S_width, int S_height, DropdownElement[] S_elements, DropdownStyle S_style, SidedRunnable S_onChange) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    selectedIndex = 0;
    open = false;
    enabled = true;
    elements = S_elements;
    style = S_style;
    onChange = S_onChange;
  }
  void render() {
    if (open && enabled) {
      style.normal._set();
      rect(x, y, width, height);
      line(x + width - height + height / 4, y + (height / 4) * 3, x + width - height / 2, y + height / 4);
      line(x + width - height / 4, y + (height / 4) * 3, x + width - height / 2, y + height / 4);
      int optionHeight = elements.length * (height / 3 * 2) + 1;
      int optiony = y;
      if (optiony + optionHeight > sketchHeight) optiony -= optiony + optionHeight - sketchHeight + 1;
      rect(x, optiony, width - height, optionHeight);
      for (int i = 0; i < elements.length; i++) {
        if (mouseX >= x && mouseX < x + width - height && mouseY >= optiony + (height / 3 * 2) * i && mouseY < optiony + (height / 3 * 2) * (i + 1)) {
          noStroke();
          fill(style.hover);
          rect(x + 1, optiony + (height / 3 * 2) * i + 1, width - height - 1, height / 3 * 2);
          if (mousePressed) {
            if (onChange != null) onChange.pre();
            selectedIndex = i;
            open = false;
            if (onChange != null) onChange.post();
          }
        }
        else if (selectedIndex == i) {
          noStroke();
          fill(style.selected);
          rect(x + 1, optiony + (height / 3 * 2) * i + 1, width - height - 1, height / 3 * 2);
        }
        style.text._text(elements[i].value, x + 5, optiony + (height / 3 * 2) * (i + 1));
      }
    }
    else
    {
      if (enabled) style.normal._set();
      else style.disabled._set();
      rect(x, y, width, height);
      line(x + width - height, y, x + width - height, y + height);
      line(x + width - height + height / 4, y + height / 4, x + width - height / 2, y + (height / 4) * 3);
      line(x + width - height / 4, y + height / 4, x + width - height / 2, y + (height / 4) * 3);
      if (enabled) style.text._set();
      else style.textDisabled._set();
      text(elements[selectedIndex].value, x + 5, y + height / 4 * 3);
    }
  }
  //do clicked in mousePressed
  void clicked() {
    if (enabled) {
      if (open) {
      int optionHeight = elements.length * (height / 3 * 2) + 1;
      int optiony = y;
      if (optiony + optionHeight > sketchHeight) optiony -= optiony + optionHeight - sketchHeight + 1;
        if (mouseX < x || mouseX > x + width - height || mouseY < optiony || mouseY > optiony + optionHeight) open = false;
      }
      else if (!open && mouseX >= x && mouseX < x + width && mouseY >= y && mouseY < y + height && elements.length >= 1) open = true;
    }
  }
}

class TextInputStyle {
  TextStyle text;
  TextStyle textExample;
  TextStyle textDisabled;
  Style normal;
  Style selected;
  Style disabled;
  TextInputStyle() {
    text = new TextStyle(0);
    textExample = new TextStyle(127);
    textDisabled = new TextStyle(192);
    normal = new Style(255, 127, 1);
    selected = new Style(255, #60afff, 3);
    disabled = new Style(255, 192, 1);
  }
  TextInputStyle(TextStyle S_text, TextStyle S_textExample, TextStyle S_textDisabled, Style S_normal, Style S_selected, Style S_disabled) {
    text = S_text;
    textExample = S_textExample;
    textDisabled = S_textDisabled;
    normal = S_normal;
    selected = S_selected;
    disabled = S_disabled;
  }
}

class TextInput {
  TextInputStyle style;
  int x;
  int y;
  int width;
  int height;
  int cursorPos;
  boolean password;
  boolean numeric;
  boolean selected;
  boolean enabled;
  String text;
  String example;
  int lastMillis;
  int barTimer;
  Runnable onEnter;
  TextInput(int S_x, int S_y, int S_width, int S_height, boolean S_password, boolean S_numeric) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    password = S_password;
    numeric = S_numeric;
    selected = false;
    enabled = true;
    text = "";
    example = "";
    onEnter = null;
    style = new TextInputStyle();
    barTimer = 0;
    lastMillis = millis();
  }
  TextInput(int S_x, int S_y, int S_width, int S_height, boolean S_password, boolean S_numeric, TextInputStyle S_style) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    password = S_password;
    numeric = S_numeric;
    selected = false;
    enabled = true;
    text = "";
    example = "";
    onEnter = null;
    style = S_style;
    barTimer = 0;
    lastMillis = millis();
  }
  TextInput(int S_x, int S_y, int S_width, int S_height, boolean S_password, boolean S_numeric, String S_example) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    password = S_password;
    numeric = S_numeric;
    selected = false;
    enabled = true;
    text = "";
    example = S_example;
    onEnter = null;
    style = new TextInputStyle();
    barTimer = 0;
    lastMillis = millis();
  }
  TextInput(int S_x, int S_y, int S_width, int S_height, boolean S_password, boolean S_numeric, String S_example, TextInputStyle S_style) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    password = S_password;
    numeric = S_numeric;
    selected = false;
    enabled = true;
    text = "";
    example = S_example;
    onEnter = null;
    style = S_style;
    barTimer = 0;
    lastMillis = millis();
  }
  TextInput(int S_x, int S_y, int S_width, int S_height, boolean S_password, boolean S_numeric, Runnable S_onEnter) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    password = S_password;
    numeric = S_numeric;
    selected = false;
    enabled = true;
    text = "";
    example = "";
    onEnter = S_onEnter;
    style = new TextInputStyle();
    barTimer = 0;
    lastMillis = millis();
  }
  TextInput(int S_x, int S_y, int S_width, int S_height, boolean S_password, boolean S_numeric, TextInputStyle S_style, Runnable S_onEnter) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    password = S_password;
    numeric = S_numeric;
    selected = false;
    enabled = true;
    text = "";
    example = "";
    onEnter = S_onEnter;
    style = S_style;
    barTimer = 0;
    lastMillis = millis();
  }
  TextInput(int S_x, int S_y, int S_width, int S_height, boolean S_password, boolean S_numeric, String S_example, Runnable S_onEnter) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    password = S_password;
    numeric = S_numeric;
    selected = false;
    enabled = true;
    text = "";
    example = S_example;
    onEnter = S_onEnter;
    style = new TextInputStyle();
    barTimer = 0;
    lastMillis = millis();
  }
  TextInput(int S_x, int S_y, int S_width, int S_height, boolean S_password, boolean S_numeric, String S_example, TextInputStyle S_style, Runnable S_onEnter) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    password = S_password;
    numeric = S_numeric;
    selected = false;
    enabled = true;
    text = "";
    example = S_example;
    onEnter = S_onEnter;
    style = S_style;
    barTimer = 0;
    lastMillis = millis();
  }
  void display() {
    if (enabled && selected) style.selected._set();
    else if (enabled) style.normal._set();
    else style.disabled._set();
    rect(x, y, width, height);
    if (enabled && text.equals("") && !example.equals("")) style.textExample._set();
    else if (enabled) style.text._set();
    else style.textDisabled._set();
    if (text.equals("") && !example.equals("")) text(example, x + 3, y + height - 3);
    else text(text, x + 3, y + height - 3);
    String left = "";
    for (int i = 0; i < cursorPos; i++) {
      left += text.charAt(i);
    }
    strokeWeight(1);
    barTimer += millis() - lastMillis;
    lastMillis = millis();
    if (barTimer >= 1000) {
      barTimer -= 1000;
    }
    if (barTimer < 500 && selected) stroke(0, 255);
    else noStroke();
    line(x + 3 + textWidth(left), y + 2, x + 3 + textWidth(left), y + height - 2);
  }
  boolean mouseOver() {
    return mouseX >= x && mouseX <= x + width - 1 && mouseY >= y && mouseY <= y + height - 1;
  }
  //do select in mousePressed
  void select() {
    selected = mouseOver() && enabled;
  }
  //do render in keyPressed
  void render() {
    if (enabled && selected) {
      style.text._set();
      char pressed = key;
      int code = keyCode;
      if (pressed == ENTER || pressed == RETURN) {
        if (onEnter != null) onEnter.run();
      }
      else if (pressed == BACKSPACE) {
        String pre = "";
        String post = "";
        boolean isPost = false;
        for (int i = 0; i < text.length(); i++) {
          if (i == cursorPos) isPost = true;
          if (isPost) post += text.charAt(i);
          else if (i < cursorPos - 1) pre += text.charAt(i);
        }
        text = pre + post;
        if (cursorPos > 0) cursorPos --;
      }
      else if (pressed == '\f' || pressed == TAB);
      else if (pressed == CODED) {
        if (code == LEFT) {
          if (cursorPos > 0) cursorPos --;
        }
        else if (code == RIGHT) {
          if (cursorPos < text.length()) cursorPos ++;
        }
      }
      else if (textWidth(text + pressed) <= width - 6 && !(numeric && "0123456789".indexOf(pressed) < 0)) {
        String pre = "";
        String post = "";
        boolean isPost = false;
        for (int i = 0; i < text.length(); i++) {
          if (i == cursorPos) isPost = true;
          if (isPost) post += text.charAt(i);
          else pre += text.charAt(i);
        }
        text = pre + pressed + post;
        cursorPos ++;
      }
      barTimer = 0;
      lastMillis = millis();
    }
  }
}

class ButtonStyle {
  TextStyle text;
  TextStyle textDisabled;
  Style normal;
  Style hover;
  Style pressed;
  Style disabled;
  ButtonStyle() {
    text = new TextStyle(0, 12, CENTER);
    textDisabled = new TextStyle(200, 12, CENTER);
    normal = new Style(255, 127, 1);
    hover = new Style(#91c8ff, #60afff, 3);
    pressed = new Style(#3c3fe8, #656691, 1);
    disabled = new Style(255, 200, 1);
  }
  ButtonStyle(TextStyle S_text, TextStyle S_textDisabled, Style S_normal, Style S_hover, Style S_pressed, Style S_disabled) {
    text = S_text;
    textDisabled = S_textDisabled;
    normal = S_normal;
    hover = S_hover;
    pressed = S_pressed;
    disabled = S_disabled;
    //make proper alignment stuffs (_textInRect()?)
    text.align = CENTER;
    textDisabled.align = CENTER;
  }
}

class Button {
  int x;
  int y;
  int width;
  int height;
  String text;
  boolean enabled;
  boolean wasPressed;
  boolean dEdge;
  ButtonStyle style;
  AdvRunnable onPress;
  Button(int S_x, int S_y, int S_width, int S_height, String S_text, boolean S_dEdge, ButtonStyle S_style) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    text = S_text;
    enabled = true;
    style = S_style;
    onPress = null;
    wasPressed = false;
    dEdge = S_dEdge;
  }
  Button(int S_x, int S_y, int S_width, int S_height, String S_text, boolean S_dEdge) {
    x = S_x;
    y = S_y;
    if (S_width > ceil(textWidth(S_text))) width = S_width;
    else width = ceil(textWidth(S_text));
    height = S_height;
    text = S_text;
    enabled = true;
    style = new ButtonStyle();
    onPress = null;
    wasPressed = false;
    dEdge = S_dEdge;
  }
  Button(int S_x, int S_y, int S_width, int S_height, String S_text, boolean S_dEdge, ButtonStyle S_style, final Runnable S_onPress) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    text = S_text;
    enabled = true;
    style = S_style;
    onPress = advRunnable(S_onPress);
    wasPressed = false;
    dEdge = S_dEdge;
  }
  Button(int S_x, int S_y, int S_width, int S_height, String S_text, boolean S_dEdge, Runnable S_onPress) {
    x = S_x;
    y = S_y;
    if (S_width > ceil(textWidth(S_text))) width = S_width;
    else width = ceil(textWidth(S_text));
    height = S_height;
    text = S_text;
    enabled = true;
    style = new ButtonStyle();
    onPress = advRunnable(S_onPress);
    wasPressed = false;
    dEdge = S_dEdge;
  }
  Button(int S_x, int S_y, int S_width, int S_height, String S_text, boolean S_dEdge, ButtonStyle S_style, AdvRunnable S_onPress) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    text = S_text;
    enabled = true;
    style = S_style;
    onPress = S_onPress;
    wasPressed = false;
    dEdge = S_dEdge;
  }
  Button(int S_x, int S_y, int S_width, int S_height, String S_text, boolean S_dEdge, AdvRunnable S_onPress) {
    x = S_x;
    y = S_y;
    if (S_width > ceil(textWidth(S_text))) width = S_width;
    else width = ceil(textWidth(S_text));
    height = S_height;
    text = S_text;
    enabled = true;
    style = new ButtonStyle();
    onPress = S_onPress;
    wasPressed = false;
    dEdge = S_dEdge;
  }
  void render() {
    if (enabled) {
      if (pressed()) {
        style.pressed._rect(x, y, width, height);
        if (onPress != null && !wasPressed) onPress.run(this);
      }
      else if (mouseOver()) {
        style.hover._rect(x, y, width, height);
      }
      else
      {
        style.normal._rect(x, y, width, height);
      }
      if (!pressed() && wasPressed && dEdge && onPress != null) onPress.run(this);
      style.text._text(text, x + width / 2, y + height - 3);
      wasPressed = pressed();
    }
    else
    {
      style.disabled._rect(x, y, width, height);
      style.textDisabled._text(text, x + width / 2,  y + height - 3);
    }
  }
  void render(PApplet app, int mouseX, int mouseY, boolean mousePressed) {
    if (enabled) {
      if (pressed(mouseX, mouseY, mousePressed)) {
        style.pressed._rect(x, y, width, height, app.g);
        if (onPress != null && !wasPressed) onPress.run(this);
      }
      else if (mouseOver(mouseX, mouseY)) {
        style.hover._rect(x, y, width, height, app.g);
      }
      else
      {
        style.normal._rect(x, y, width, height, app.g);
      }
      if (!pressed(mouseX, mouseY, mousePressed) && wasPressed && dEdge && onPress != null) onPress.run(this);
      style.text._text(text, x + width / 2, y + height - 3, app.g);
      wasPressed = pressed(mouseX, mouseY, mousePressed);
    }
    else
    {
      style.disabled._rect(x, y, width, height, app.g);
      style.textDisabled._text(text, x + width / 2,  y + height - 3, app.g);
    }
  }
  void setEnabled(boolean S_enabled) {
    enabled = S_enabled;
  }
  boolean isEnabled() {
    return enabled;
  }
  boolean pressed() {
    return mousePressed && enabled && mouseOver();
  }
  boolean mouseOver() {
    return mouseX >= x && mouseX <= x + width - 1 && mouseY >= y && mouseY <= y + height - 1;
  }
  boolean pressed(int mouseX, int mouseY, boolean mousePressed) {
    return mousePressed && enabled && mouseOver(mouseX, mouseY);
  }
  boolean mouseOver(int mouseX, int mouseY) {
    return mouseX >= x && mouseX <= x + width - 1 && mouseY >= y && mouseY <= y + height - 1;
  }
}

class TextureButtonStyle {
  PImage normal;
  PImage hover;
  PImage pressed;
  PImage disabled;
  TextureButtonStyle(PImage S_normal, PImage S_hover, PImage S_pressed, PImage S_disabled) {
    normal = S_normal;
    hover = S_hover;
    pressed = S_pressed;
    disabled = S_disabled;
  }
}

class TextureButton {
  int x;
  int y;
  int width;
  int height;
  boolean enabled;
  boolean wasPressed;
  boolean dEdge;
  TextureButtonStyle style;
  AdvRunnable onPress;
  TextureButton(int S_x, int S_y, int S_width, int S_height, boolean S_dEdge, TextureButtonStyle S_style) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    enabled = true;
    style = S_style;
    onPress = null;
    wasPressed = false;
    dEdge = S_dEdge;
  }
  TextureButton(int S_x, int S_y, int S_width, int S_height, boolean S_dEdge, TextureButtonStyle S_style, Runnable S_onPress) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    enabled = true;
    style = S_style;
    onPress = advRunnable(S_onPress);
    wasPressed = false;
    dEdge = S_dEdge;
  }
  TextureButton(int S_x, int S_y, int S_width, int S_height, boolean S_dEdge, TextureButtonStyle S_style, AdvRunnable S_onPress) {
    x = S_x;
    y = S_y;
    width = S_width;
    height = S_height;
    enabled = true;
    style = S_style;
    onPress = S_onPress;
    wasPressed = false;
    dEdge = S_dEdge;
  }
  void render() {
    if (enabled) {
      if (pressed()) {
        image(style.pressed, x, y, width, height);
        if (onPress != null && !wasPressed) onPress.run(this);
      }
      else if (mouseOver()) {
        image(style.hover, x, y, width, height);
      }
      else
      {
        image(style.normal, x, y, width, height);
      }
      if (!pressed() && wasPressed && dEdge && onPress != null) onPress.run(this);
      wasPressed = pressed();
    }
    else
    {
      image(style.disabled, x, y, width, height);
    }
  }
  void render(PGraphics p, int mouseX, int mouseY, boolean mousePressed) {
    if (enabled) {
      if (pressed(mouseX, mouseY, mousePressed)) {
        p.image(style.pressed, x, y, width, height);
        if (onPress != null && !wasPressed) onPress.run(this);
      }
      else if (mouseOver(mouseX, mouseY)) {
        p.image(style.hover, x, y, width, height);
      }
      else
      {
        p.image(style.normal, x, y, width, height);
      }
      if (!pressed(mouseX, mouseY, mousePressed) && wasPressed && dEdge && onPress != null) onPress.run(this);
      wasPressed = pressed(mouseX, mouseY, mousePressed);
    }
    else
    {
      p.image(style.disabled, x, y, width, height);
    }
  }
  void setEnabled(boolean S_enabled) {
    enabled = S_enabled;
  }
  boolean isEnabled() {
    return enabled;
  }
  boolean pressed() {
    return mousePressed && enabled && mouseOver();
  }
  boolean mouseOver() {
    return mouseX >= x && mouseX <= x + width - 1 && mouseY >= y && mouseY <= y + height - 1;
  }
  boolean pressed(int mouseX, int mouseY, boolean mousePressed) {
    return mousePressed && enabled && mouseOver(mouseX, mouseY);
  }
  boolean mouseOver(int mouseX, int mouseY) {
    return mouseX >= x && mouseX <= x + width - 1 && mouseY >= y && mouseY <= y + height - 1;
  }
}

class ScrollBar {
  int x;
  int y;
  int length;
  int max;
  int value;
  boolean vertical;
  ScrollBar(boolean S_vertical, int S_x, int S_y, int S_length, int S_max) {
    x = S_x;
    y = S_y;
    length = S_length;
    vertical = S_vertical;
    max = S_max;
  }
  void display() {
    if (max > 0) {
      int barLength = length / max;
      if (barLength < 10) barLength = 10;
      float pixelPerValue = (length - barLength) / max;
      float pixelOffset = pixelPerValue * value;
      if (vertical) {
        noStroke();
        fill(127);
        ellipse(x + 5, y + 5 + pixelOffset, 10, 10);
        ellipse(x + 5, y + 5 + pixelOffset + barLength - 10, 10, 10);
        rect(x, y + 5 + pixelOffset, 10, barLength - 10);
      }
      else
      {
        
      }
    }
  }
  void scroll(int scroll) {
    value += scroll;
    if (value < 0) value = 0;
    if (value > max) value = max;
  }
}

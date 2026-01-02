# دليل التحويل إلى Godot 4

## نظرة عامة

تم بنجاح تحويل مشروع **Thieves City** من Godot 3.x إلى Godot 4.x مع تحديث جميع السكريبتات والمشاهد للتوافق الكامل.

---

## التغييرات الرئيسية

### 1. ملف المشروع (project.godot)

**التغييرات:**
- `config_version=4` → `config_version=5`
- إزالة `_global_script_classes` و `_global_script_class_icons`
- تحديث `config/features` إلى `PackedStringArray("4.3", "Mobile")`
- تحديث إعدادات العرض (rendering)

---

### 2. السكريبتات (GDScript)

#### أ. أنواع العقد (Node Types)

**قبل (Godot 3):**
```gdscript
extends KinematicBody2D
```

**بعد (Godot 4):**
```gdscript
extends CharacterBody2D
```

**الملفات المتأثرة:**
- `Player.gd`
- `AIPlayer.gd`

---

#### ب. نظام الحركة

**قبل (Godot 3):**
```gdscript
velocity = move_and_slide(velocity)
```

**بعد (Godot 4):**
```gdscript
# velocity أصبح خاصية مدمجة
velocity = input_vector * SPEED
move_and_slide()
```

**الملفات المتأثرة:**
- `Player.gd`
- `AIPlayer.gd`

---

#### ج. نظام الإشارات (Signals)

**قبل (Godot 3):**
```gdscript
signal money_changed
emit_signal("money_changed", new_amount)
connect("money_changed", self, "_on_money_changed")
```

**بعد (Godot 4):**
```gdscript
signal money_changed(new_amount)
money_changed.emit(new_amount)
money_changed.connect(_on_money_changed)
```

**الملفات المتأثرة:**
- `GameManager.gd`
- `Player.gd`
- `AIPlayer.gd`
- `VirtualJoystick.gd`
- `UI.gd`

---

#### د. نظام الملفات (File System)

**قبل (Godot 3):**
```gdscript
var file = File.new()
file.open(path, File.READ)
var text = file.get_as_text()
file.close()

var data = parse_json(text)
```

**بعد (Godot 4):**
```gdscript
var file = FileAccess.open(path, FileAccess.READ)
if file:
    var text = file.get_as_text()
    file.close()
    
    var json = JSON.new()
    var parse_result = json.parse(text)
    if parse_result == OK:
        var data = json.data
```

**الملفات المتأثرة:**
- `GameManager.gd`
- `SaveSystem.gd`

---

#### هـ. واجهات النظام (OS APIs)

**قبل (Godot 3):**
```gdscript
OS.get_ticks_msec()
OS.has_touchscreen_ui_hint()
randomize()
```

**بعد (Godot 4):**
```gdscript
Time.get_ticks_msec()
DisplayServer.is_touchscreen_available()
# randomize() لم يعد ضرورياً (تلقائي)
```

**الملفات المتأثرة:**
- `VirtualJoystick.gd`
- `AIPlayer.gd`

---

#### و. واجهة المستخدم (UI)

**قبل (Godot 3):**
```gdscript
label.rect_position = Vector2(10, 10)
label.rect_size = Vector2(100, 50)
label.add_font_override("font", font)
control.anchor_right = 1.0
```

**بعد (Godot 4):**
```gdscript
label.position = Vector2(10, 10)
label.size = Vector2(100, 50)
label.add_theme_font_size_override("font_size", 24)
control.anchor_right = 1.0  # لم يتغير
```

**الملفات المتأثرة:**
- `UI.gd`
- `VirtualJoystick.gd`

---

### 3. المشاهد (.tscn)

#### أ. تنسيق الملف

**قبل (Godot 3):**
```
[gd_scene load_steps=3 format=2]
```

**بعد (Godot 4):**
```
[gd_scene load_steps=3 format=3 uid="uid://unique_id"]
```

---

#### ب. أسماء العقد

**قبل (Godot 3):**
- `KinematicBody2D`
- `Sprite`

**بعد (Godot 4):**
- `CharacterBody2D`
- `Sprite2D`

---

#### ج. الموارد (Resources)

**قبل (Godot 3):**
```
[ext_resource path="res://script.gd" type="Script" id=1]
```

**بعد (Godot 4):**
```
[ext_resource type="Script" path="res://script.gd" id="1"]
```

**الملفات المتأثرة:**
- `Player.tscn`
- `AIPlayer.tscn`
- `Loot.tscn`
- `Main.tscn`

---

## قائمة الملفات المحدثة

### السكريبتات (7 ملفات)
1. ✅ `Player.gd` - تحويل إلى CharacterBody2D
2. ✅ `AIPlayer.gd` - تحديث نظام الحركة والإشارات
3. ✅ `VirtualJoystick.gd` - تحديث واجهات OS و UI
4. ✅ `GameManager.gd` - تحديث نظام الملفات والإشارات
5. ✅ `UI.gd` - تحديث واجهة المستخدم
6. ✅ `Loot.gd` - تحديث الإشارات
7. ✅ `Main.gd` - تحديث الإشارات

### المشاهد (4 ملفات)
1. ✅ `Player.tscn` - تحديث التنسيق والعقد
2. ✅ `AIPlayer.tscn` - تحديث التنسيق والعقد
3. ✅ `Loot.tscn` - تحديث التنسيق والعقد
4. ✅ `Main.tscn` - تحديث التنسيق والعقد

### الإعدادات (1 ملف)
1. ✅ `project.godot` - تحديث الإصدار والإعدادات

---

## الميزات المحافظ عليها

✅ جميع آليات اللعب الأساسية  
✅ نظام التحكم الذكي (كيبورد + عصا افتراضية)  
✅ 30 لاعب AI بذكاء متقدم  
✅ نظام جمع الأغراض  
✅ آلية السرقة عند الاصطدام  
✅ نظام المؤقت والترتيب  
✅ نظام الحفظ والتحميل  
✅ التوافق مع جميع المنصات  

---

## كيفية التشغيل

### 1. فتح المشروع في Godot 4

```bash
# استنساخ المشروع
git clone https://github.com/elith-bot/Thieves-City.git
cd Thieves-City

# فتح في Godot 4
godot4 --path .
```

### 2. التشغيل المباشر

اضغط **F5** في محرر Godot 4 لتشغيل اللعبة مباشرة.

### 3. البناء للمنصات المختلفة

#### Android
```
Project → Export → Android
```

#### iOS
```
Project → Export → iOS
```

#### Web (HTML5)
```
Project → Export → Web
```

#### Desktop (Windows/macOS/Linux)
```
Project → Export → [Platform]
```

---

## الاختلافات الرئيسية عن Godot 3

### الأداء
- **أسرع**: Godot 4 أسرع بشكل عام بفضل المحرك المحسّن
- **رسومات أفضل**: دعم أفضل لـ Vulkan و OpenGL

### الميزات الجديدة
- **GDScript محسّن**: أداء أفضل وميزات جديدة
- **نظام فيزياء محسّن**: أكثر دقة واستقراراً
- **واجهات API محسّنة**: أسهل في الاستخدام

### التوافق
- **المنصات**: دعم أفضل لجميع المنصات
- **الأجهزة المحمولة**: تحسينات كبيرة للأندرويد و iOS

---

## المشاكل المحتملة والحلول

### المشكلة 1: الصور لا تظهر

**السبب:** تغيير `Sprite` إلى `Sprite2D`

**الحل:**
```gdscript
# في السكريبت
var sprite_node = get_node_or_null("Sprite2D")  # بدلاً من "Sprite"
```

### المشكلة 2: الحركة لا تعمل

**السبب:** تغيير طريقة `move_and_slide()`

**الحل:**
```gdscript
# تأكد من أن velocity خاصية
velocity = direction * SPEED
move_and_slide()  # بدون معاملات
```

### المشكلة 3: الإشارات لا تعمل

**السبب:** تغيير صيغة الإشارات

**الحل:**
```gdscript
# استخدم .emit() بدلاً من emit_signal()
signal_name.emit(value)

# استخدم .connect() مباشرة
signal_name.connect(callback_function)
```

---

## الخلاصة

تم بنجاح تحويل المشروع إلى Godot 4 مع:
- ✅ تحديث جميع السكريبتات (7 ملفات)
- ✅ تحديث جميع المشاهد (4 ملفات)
- ✅ تحديث ملف المشروع
- ✅ الحفاظ على جميع الميزات
- ✅ التوافق الكامل مع Godot 4.3+

**المشروع الآن جاهز للتشغيل على Godot 4!** 🎉

---

**تاريخ التحويل**: 2 يناير 2026  
**الإصدار**: v0.3.0 (Godot 4 Compatible)  
**الحالة**: ✅ **مكتمل ومتوافق**

![LOGO](https://github.com/omid-hdr/Digital_System_Design/blob/main/Document/image/Untitled.jpg)
# Elevator simulation
در این پروژه قصد داریم شبیه سازی آسانسور داشته باشیم.در واقع کنترلر آسانسور را بزنیم.شامل طبقه همکف یا همان 0 و 4 طبقه دیگر است.هر طبقه کلید دارد و درون آسانسور نیز میتوان به هر طبقه درخواست داد. آسانسور باید به ترتیبی که درخواست داده اند به طبقات برود و اگر در مسیر خود مواجه درخواستی شد همانجا توقف کند.


## Tools
- ModelSim
- Verilog
- SystemVerylog


## Implementation Details
![LOGO](https://github.com/omid-hdr/Digital_System_Design/blob/main/Document/image/Screenshot%202024-06-28%20234248.png)

برای چنین پروژه ای از سه فایل استفاده کردم. اولین فایل همان بالابر است و آدرس و وضعیت آن را اپدیت میکندد. دومی هم فایل کنترلر است و اصل منطق حرکت و توقف و جهت حرکت آسانسور و همچنین پاسخگویی به درخواست ها را بر عهده دارد.
سومی برای تست کردن که همان فایل TESTBENCH.v است.


## How to Run

just need to compile and simulate in modelsim.at first create a project or open as a project, then compile all files and a fter that select similution option on top and select our testbench in work library, then click f9 to run, if want to see wawes you should at first select signals and press ctri + V .


## Results
![LOGO](https://github.com/omid-hdr/Digital_System_Design/blob/main/Document/image/Screenshot%202024-06-29%20064855.png)
چنین است که میتوان یک سناریو را شبیه سازی کرد و سپس مورد بررسی قرار داد که چگونه عمل میکند.همچنین دو مدل خروجی داریم یکی موج که در شکل بالا مشاهده میکنید و یکی هم خروجی متنی که خودمان در تست بنچ نوشتیم.


![LOGO](https://github.com/omid-hdr/Digital_System_Design/blob/main/Document/image/Screenshot%202024-06-29%20011317.png)



## Related Links
 - https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://github.com/Ankit-kumar65/Elevator-Control-System-using-Verilog&ved=2ahUKEwiMkqb0qv-GAxUsg_0HHZjkBBgQFnoECBUQAQ&usg=AOvVaw07GmkHo4PIgQfwTOoeqVtP
 - https://github.com/Engineer-Ayesha-Shafique/Generalized-Elevator-Control-System-Using-System-Verilog

## Authors
- [Omid](https://github.com/omid-hdr)
- STU_ID: 401105859

## Date
spring 2024

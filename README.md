# CGMD-Monitor-Logs

Bash scripts สำหรับบันทึกการใช้งาน CPU, RAM, Disk และ GPU ลงไฟล์ log และบนเทอร์มินัลสำหรับดูค่าแบบเรียลไทม์
 
## Fetures
 
- บันทึก Date-time, CPU, RAM, Disk และ GPU เป็นหนึ่งบรรทัดต่อหนึ่งครั้งที่เก็บค่า
- ตั้งเวลารันด้วย `cron` ตามที่ผู้ใช้กำหนด
- แสดง `N/A` เมื่อเครื่องไม่มี NVIDIA GPU
- มีหน้าต่างแบบ Real-time ที่รีเฟรชทุก 1 วินาที

## Requirements
 
- Linux (ทดสอบบน Ubuntu/Debian)
- `bash`, `awk`, `vmstat`, `df`, `cron`
- ไม่บังคับ: `nvidia-smi` สำหรับข้อมูล GPU

## How to Use

1. Clone หรือดาวน์โหลด repository:
   ```bash
   git clone https://github.com/BlackBerry8973/CGMD-Monitor-Logs.git
   cd CGMD-Monitor-Logs
   ```
2. ทำให้สคริปต์สามารถรันได้:
   ```bash
   chmod +x CGMD-Monitor.sh CGMD-logs.sh
   ```
3. รันสคริปต์เพื่อดูข้อมูลแบบเรียลไทม์:
   ```bash
   ./CGMD-Monitor.sh
   ```
4. รันสคริปต์เพื่อบันทึกข้อมูลลงไฟล์ log:
   ```bash
   ./CGMD-logs.sh
   ```
5. ตั้งค่า `cron` เพื่อรันสคริปต์บันทึกข้อมูลอัตโนมัติทุก 5 นาที:
   ```bash
    crontab -e
    */5 * * * * /path/to/CGMD-logs.sh
    ```
6. ตรวจสอบไฟล์ log:
   ```bash
   tail -f ~/logs/resource.log
   ```
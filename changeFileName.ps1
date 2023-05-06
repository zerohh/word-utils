  # 使用方法：在本脚本上右键点击“使用PowerShell运行”即可

  $ID = Read-Host -Prompt "输入需要修改文件的后缀名"
 
# use $ID to do something...

  # 创建函数，通过随机数的设置来获取一个目标日期
  function getMyDate {
	[OutputType('System.DateTime')]
	param()
	return [datetime]('09/'+[string](Get-Random -Maximum 30)+'/'+'2022 '+[string](Get-Random -Maximum 22 -Minimum 8)+':'+[string](Get-Random -Maximum 59 -Minimum 0)+':'+[string](Get-Random -Maximum 59 -Minimum 0))
  }

  # 查询所有的类型文件，并且遍历修改文件的最后修改日期、创建日期、最后访问日期
  ls .\*.$ID | foreach-object { $_.LastWriteTime = getMyDate; $_.CreationTime = getMyDate; $_.LastAccessTime = getMyDate }

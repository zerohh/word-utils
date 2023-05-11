# 使用方法：在本脚本上右键点击“使用PowerShell运行”即可
# 定义 getMyDate 函数
function getMyDate {
  [OutputType('System.DateTime')]
  param()

  # 创建 01-12 的数字数组
  $months = 1..12 | ForEach-Object { '{0:d2}' -f $_ }

  # 如果 $uniqueMonths 变量不存在，则创建一个新数组
  if (-not $global:uniqueMonths) {
    $global:uniqueMonths = @()
  }

  # 获取未生成的月份数组
  $remainingMonths = $months | Where-Object { $global:uniqueMonths -notcontains $_ }

  # 如果所有月份都已经生成过，则重新开始
  if ($remainingMonths.Count -eq 0) {
    $global:uniqueMonths = @()
    $remainingMonths = $months
  }

  # 随机选择一个月份并添加到已生成月份数组
  $randomMonth = $remainingMonths | Get-Random
  $global:uniqueMonths += $randomMonth

  # 构造日期并输出
  return [datetime]($randomMonth + '/' + [string](Get-Random -Maximum 30) + '/2023 ' + [string](Get-Random -Maximum 22 -Minimum 8) + ':' + [string](Get-Random -Maximum 59 -Minimum 0) + ':' + [string](Get-Random -Maximum 59 -Minimum 0))
}

# 接收用户输入的文件类型
$fileTypes = Read-Host "请输入文件类型后缀,例如:jpeg(多个类型用逗号分隔，例如:jpeg,doc)"

# 将文件类型转换为数组
$fileTypesArray = $fileTypes.Split(',')

# 遍历每个文件类型并列出相应的文件
foreach ($type in $fileTypesArray) {
  # 使用通配符 * 来匹配所有指定类型的文件，并使用 ls 命令（别名为 Get-ChildItem）来列出它们
  ls *.$type | foreach-object { $_.LastWriteTime = getMyDate; $_.CreationTime = getMyDate; $_.LastAccessTime = getMyDate }
}


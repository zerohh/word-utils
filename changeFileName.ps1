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

# 查询所有的类型文件，并且遍历修改文件的最后修改日期、创建日期、最后访问日期
ls .\*.doc | foreach-object { $_.LastWriteTime = getMyDate; $_.CreationTime = getMyDate; $_.LastAccessTime = getMyDate }


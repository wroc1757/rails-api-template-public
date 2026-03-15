# AdminUser初期データ
# 本番デプロイ後は必ずパスワードを変更すること
AdminUser.find_or_create_by!(email: "admin@example.com") do |u|
  u.password = ENV.fetch("ADMIN_INITIAL_PASSWORD", "changeme_immediately")
  u.password_confirmation = ENV.fetch("ADMIN_INITIAL_PASSWORD", "changeme_immediately")
end

puts "Seed completed: AdminUser created"

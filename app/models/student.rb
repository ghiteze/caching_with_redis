class Student < ActiveRecord::Base

	after_save :clear_cache

	def self.fetch
		students = $redis.get('students')
		if students.nil?
			students = self.all.to_json
			$redis.set('students', students)
		end
		JSON.load(students)
	end

	def clear_cache
		$redis.del('students')
	end

end

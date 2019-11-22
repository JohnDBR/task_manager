
class AwsClient
  
    def initialize
      Aws.config[:credentials] = Aws::Credentials.new(
                                  ENV['TM_S3_ACCESS_KEY_ID'], 
                                  ENV['TM_S3_SECRET_ACCESS_KEY_ID']
                                )
      @sns = Aws::SNS::Resource.new(region: ENV['TM_S3_REGION'])
      @topic = @sns.topic(ENV['TM_SNS_TOPIC'])
    end
  
    def publish_message(message)
      @topic.publish({
        message: "#{DateTime.now} #{message}"
      })
    end

    def subscribe(email)
			@topic.subscribe({
				protocol: 'email',
				endpoint: email
			})
    end
  
    def parse_file_key(file_key)
      checksum = file_key.split('_').last
      file_key.split("_#{checksum}").first
    end
  
  end
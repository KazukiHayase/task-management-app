module ApplicationError
    class NotPermittedError < StandardError
        def initialize(msg="ページにアクセスする権利がありません")
            super
        end
    end
end

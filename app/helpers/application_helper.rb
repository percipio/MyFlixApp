module ApplicationHelper
        def main_image(image)
        if image.main_image.attached?
            image_tag image.main_image
        else
            image_tag "placeholder.png"
        end
    end
    
end

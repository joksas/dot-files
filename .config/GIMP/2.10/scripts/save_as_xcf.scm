(define (save_as_xcf source_filename destination_filename)
   (let* ((image (car (gimp-file-load RUN-NONINTERACTIVE source_filename source_filename)))
          (drawable (car (gimp-image-get-active-layer image))))
     (if (> (car (gimp-drawable-type drawable)) 1)
            (gimp-image-convert-rgb image)
            ()
         )  
     (gimp-file-save RUN-NONINTERACTIVE image drawable destination_filename destination_filename) 
     (gimp-image-delete image)))

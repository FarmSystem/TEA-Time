package farm.teatimeapi.utils;

import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.AmazonS3Exception;
import com.amazonaws.services.s3.model.PutObjectRequest;
import farm.teatimecore.exception.CustomException;
import farm.teatimecore.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class ImageUtil {
    private final AmazonS3Client amazonS3Client;
    @Value("${cloud.aws.s3.bucket}") private String s3Bucket;

    public String uploadImage(MultipartFile file) {
        if (file == null) {
            return null;
        }

        String fileName = makeFileName();

        try {
            amazonS3Client.putObject(new PutObjectRequest(s3Bucket, fileName, file.getInputStream(), null));
            return amazonS3Client.getUrl(s3Bucket, fileName).toString();
        } catch (IOException e) {
            throw new CustomException(ErrorCode.FILE_UPLOAD_ERROR);
        }
    }

    public String updateImage(MultipartFile file, String path) {
        deleteS3File(path);
        return uploadImage(file);
    }

    public void deleteS3File(String path) {
        try {
            amazonS3Client.deleteObject(s3Bucket, path);
        } catch (AmazonS3Exception e) {
            throw new CustomException(ErrorCode.FILE_DELETE_ERROR);
        }
    }

    private String makeFileName() {
        return LocalDateTime.now().toString() + UUID.randomUUID() + ".png";
    }
}

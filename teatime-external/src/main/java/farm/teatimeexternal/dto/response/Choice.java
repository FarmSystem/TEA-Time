package farm.teatimeexternal.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimeexternal.dto.request.Message;

public record Choice(
        @JsonProperty("index") Integer index,
        @JsonProperty("message") Message message
) {
}

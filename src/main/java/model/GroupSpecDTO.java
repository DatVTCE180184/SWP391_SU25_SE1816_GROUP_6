package model; 
// mới tạo để gom nhóm cho  thông số kỹ thuật 
import java.util.List;

public class GroupSpecDTO {
    private int groupId;
    private String groupName;
    private List<ProductSpec> specList;

    public GroupSpecDTO(int groupId, String groupName, List<ProductSpec> specList) {
        this.groupId = groupId;
        this.groupName = groupName;
        this.specList = specList;
    }

    public int getGroupId() { return groupId; }
    public String getGroupName() { return groupName; }
    public List<ProductSpec> getSpecList() { return specList; }
    
    
} 
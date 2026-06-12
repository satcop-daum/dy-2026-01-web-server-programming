package kr.ac.dy.cs.adminUser;

public class AdminUserService {

    private final AdminUserRepository adminUserRepository;

    public AdminUserService() {
        adminUserRepository = new AdminUserRepository();
    }

    /**
     * 관리자 로그인 여부 리턴
     */
    public boolean isLogin(String adminId, String password) {

        AdminUserDto adminUser = adminUserRepository.getAdminUser(adminId);
        if (adminUser == null) {
            return false;
        }


        if (password == null || !password.equals(adminUser.getPassword())) {
            return false;
        }





        return true;
    }


}

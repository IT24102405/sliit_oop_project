<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Add this right after the opening <body> tag -->
<c:if test="${empty user or user.role ne 'admin'}">
    <c:redirect url="/dashboard.jsp?error=Access denied. Admin privileges required."/>
</c:if>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="userUtil" class="com.inventory_and_stock_management.utils.UserUtil" />
<c:set var="users" value="${userUtil.readUsers()}" />


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - Vehicle Parking Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Vehicle Parking System</a>
            <div class="navbar-collapse">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="userManagement.jsp">User Management</a>
                    </li>
                </ul>
                <span class="navbar-text me-3">Welcome, ${user.username} (${user.role})</span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2>User Management</h2>

        <!-- Success/Error Messages -->
        <c:if test="${not empty param.message}">
            <div class="alert alert-success">${param.message}</div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger">${param.error}</div>
        </c:if>

        <!-- Add User Button -->
        <button class="btn btn-primary mb-3"
                data-bs-toggle="modal"
                data-bs-target="#addUserModal">
            Add New User
        </button>


        <div class="d-flex justify-content-between mb-3">


            <div class="col-md-6">
                <div class="input-group">
                    <input type="text" id="searchInput" class="form-control" placeholder="Search by username, email or role...">
                    <button class="btn btn-outline-secondary" type="button" id="searchButton">
                        <i class="bi bi-search"></i> Search
                    </button>
                </div>
            </div>
        </div>

        <!-- Users Table -->
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.username}</td>
                        <td>${user.email}</td>
                        <td>${user.role}</td>
                        <td>
                            <button class="btn btn-sm btn-warning"
                                    onclick="openEditModal('${user.username}', '${user.email}', '${user.role}')">
                                Edit
                            </button>
                            <a href="${pageContext.request.contextPath}/delete-user?username=${user.username}"
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('Are you sure you want to delete this user?')">
                                Delete
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Add User Modal -->
    <div class="modal fade" id="addUserModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New User</h5>
                    <button class="btn btn-primary mb-3"
                            data-bs-toggle="modal"
                            data-bs-target="#addUserModal">
                        Add New User
                    </button>
                </div>
                <form action="${pageContext.request.contextPath}/add-user" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Role</label>
                            <select class="form-select" name="role" required>
                                <option value="user">User</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add User</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit User Modal -->
    <div class="modal fade" id="editUserModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit User</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="editForm" action="${pageContext.request.contextPath}/update-user" method="post">
                    <div class="modal-body">
                        <input type="hidden" id="editUsername" name="username">
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" id="editEmail" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">New Password (leave blank to keep current)</label>
                            <input type="password" class="form-control" name="password" placeholder="Leave blank to keep current password">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Role</label>
                            <select class="form-select" id="editRole" name="role" required>
                                <option value="user">User</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function openEditModal(username, email, role) {
            // Set form values
            document.getElementById('editUsername').value = username;
            document.getElementById('editEmail').value = email;
            document.getElementById('editRole').value = role;

            // Clear password field when opening modal
            document.querySelector('#editUserModal input[name="password"]').value = '';

            // Show modal
            var editModal = new bootstrap.Modal(document.getElementById('editUserModal'));
            editModal.show();
        }

        // Add form validation
        document.getElementById('editForm').addEventListener('submit', function(e) {
            if (!confirm('Are you sure you want to update this user?')) {
                e.preventDefault();
            }
        });
    </script>
    <script>
    // Search functionality
    document.addEventListener('DOMContentLoaded', function() {
        const searchInput = document.getElementById('searchInput');
        const searchButton = document.getElementById('searchButton');
        const userRows = document.querySelectorAll('tbody tr');

        function filterUsers() {
            const searchTerm = searchInput.value.toLowerCase();

            userRows.forEach(row => {
                const username = row.cells[0].textContent.toLowerCase();
                const email = row.cells[1].textContent.toLowerCase();
                const role = row.cells[2].textContent.toLowerCase();

                if (username.includes(searchTerm) ||
                    email.includes(searchTerm) ||
                    role.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        // Search as you type
        searchInput.addEventListener('input', filterUsers);

        // Also search when button is clicked
        searchButton.addEventListener('click', filterUsers);

        // Clear search when clicking the 'X' in search input
        searchInput.addEventListener('search', filterUsers);
    });
    </script>
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Debug script -->
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Bootstrap version:', bootstrap.Tooltip.VERSION);

        // Test modal programmatically
        document.querySelector('[data-bs-target="#addUserModal"]').addEventListener('click', function() {
            console.log('Add User button clicked');
        });
    });
    </script>
</body>
</html>
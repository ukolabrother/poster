<#macro login path isRegisterForm>
    <form method="post" action="${path}">
        <div class="form-group col-md-4">
            <label for="exampleInputEmail1">User Name:</label>
            <input type="text" class="form-control  ${(usernameError??)?string('is-invalid', '')}"
                   name="username" aria-describedby="emailHelp" value="<#if user??>${user.username}</#if>"
                   placeholder="input login"/>
            <#if usernameError??>
                <div class="invalid-feedback">
                    ${usernameError}
                </div>
            </#if>
        </div>
        <div class="form-group col-md-4">
            <label for="exampleInputPassword1">Password:</label>
            <input type="password" class="form-control ${(passwordError??)?string('is-invalid', '')}"
                   name="password" placeholder="input password"/>
            <#if passwordError??>
                <div class="invalid-feedback">
                    ${passwordError}
                </div>
            </#if>
        </div>
        <#if isRegisterForm>
            <div class="form-group col-md-4">
                <label for="exampleInputPassword1">Password:</label>
                <input type="password" class="form-control ${(password2Error??)?string('is-invalid', '')}"
                       name="password2" placeholder="retype password"/>
                <#if password2Error??>
                    <div class="invalid-feedback">
                        ${password2Error}
                    </div>
                </#if>
            </div>
            <div class="form-group col-md-4">
                <label for="exampleInputPassword1">Email:</label>
                <input type="email" class="form-control ${(emailError??)?string('is-invalid', '')}"
                       value="<#if user??>${user.email}</#if>"
                       name="email" placeholder="input email"/>
                <#if emailError??>
                    <div class="invalid-feedback">
                        ${emailError}
                    </div>
                </#if>
            </div>
            <div class="col-sm-6">
                <div class="g-recaptcha" data-sitekey="6LeKE2EfAAAAAIk4dSGzlbGWG8DGntmuJD1UhcxM"></div>
                <#if captchaError??>
                    <div class="alert alert-danger" role="alert">
                        ${captchaError}
                    </div>
                </#if>
            </div>
        </#if>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <#if !isRegisterForm>
            <a href="registration">add new user</a>
        </#if>
        <button type="submit" class="btn btn-primary">
            <#if isRegisterForm>
                Create
            <#else>
                Sign in
            </#if>
        </button>
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary">Sign Out</button>
    </form>
</#macro>
<#macro login path isRegisterForm>
    <form method="post" action="${path}">
        <div class="form-group col-md-4">
            <label for="exampleInputEmail1">User Name:</label>
            <input type="text" class="form-control" name="username" aria-describedby="emailHelp"
                   placeholder="input login"/>
        </div>
        <div class="form-group col-md-4">
            <label for="exampleInputPassword1">Password:</label>
            <input type="password" class="form-control" name="password" placeholder="input password"/>
        </div>
        <#if isRegisterForm>
            <div class="form-group col-md-4">
                <label for="exampleInputPassword1">Email:</label>
                <input type="email" class="form-control" name="email" placeholder="input email"/>
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
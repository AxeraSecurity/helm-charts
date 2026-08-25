CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "AspNetRoles" (
        "Id" text NOT NULL,
        "Name" character varying(256),
        "NormalizedName" character varying(256),
        "ConcurrencyStamp" text,
        CONSTRAINT "PK_AspNetRoles" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "AspNetUsers" (
        "Id" text NOT NULL,
        "RefreshToken" text,
        "RefreshTokenExpiration" timestamp with time zone NOT NULL,
        "Role" text NOT NULL,
        "AccountCreated" timestamp with time zone NOT NULL,
        "DefaultMode" text NOT NULL,
        "UserName" character varying(256),
        "NormalizedUserName" character varying(256),
        "Email" character varying(256),
        "NormalizedEmail" character varying(256),
        "EmailConfirmed" boolean NOT NULL,
        "PasswordHash" text,
        "SecurityStamp" text,
        "ConcurrencyStamp" text,
        "PhoneNumber" text,
        "PhoneNumberConfirmed" boolean NOT NULL,
        "TwoFactorEnabled" boolean NOT NULL,
        "LockoutEnd" timestamp with time zone,
        "LockoutEnabled" boolean NOT NULL,
        "AccessFailedCount" integer NOT NULL,
        CONSTRAINT "PK_AspNetUsers" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "KubernetesPushCronResults" (
        "Id" uuid NOT NULL,
        "Payload" text NOT NULL,
        "Crontab" text NOT NULL,
        "Immediate" boolean NOT NULL,
        "JobId" text NOT NULL,
        "ScheduledAt" timestamp with time zone,
        "EnqueuedAt" timestamp with time zone,
        "StartedAt" timestamp with time zone,
        "CompletedAt" timestamp with time zone,
        "Succeeded" boolean,
        "Error" text NOT NULL,
        "Status" integer NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone,
        CONSTRAINT "PK_KubernetesPushCronResults" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "NetworkPolicyRecords" (
        "Id" uuid NOT NULL,
        "Name" character varying(200) NOT NULL,
        "ClusterName" character varying(200) NOT NULL,
        "CreatedBy" character varying(200) NOT NULL,
        "Created" timestamp with time zone NOT NULL DEFAULT (now()),
        "VersionNumber" integer NOT NULL,
        "RevertedBy" character varying(200) NOT NULL DEFAULT '',
        "LastRevertedTime" timestamp with time zone NOT NULL DEFAULT (now()),
        "MergedBy" character varying(200) NOT NULL DEFAULT '',
        "LastMergeTime" timestamp with time zone NOT NULL DEFAULT (now()),
        "LastModifiedTime" timestamp with time zone NOT NULL DEFAULT (now()),
        "LastHitTime" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity',
        "NetworkPolicyHash" character varying(128) NOT NULL DEFAULT '',
        "NetworkPolicy" jsonb NOT NULL,
        CONSTRAINT "PK_NetworkPolicyRecords" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "OldNetworkPolicyRecords" (
        "Id" uuid NOT NULL,
        "Name" character varying(200) NOT NULL,
        "ClusterName" character varying(200) NOT NULL,
        "CreatedBy" character varying(200) NOT NULL,
        "Created" timestamp with time zone NOT NULL DEFAULT (now()),
        "VersionNumber" integer NOT NULL DEFAULT 1,
        "RevertedBy" character varying(200) NOT NULL DEFAULT '',
        "LastRevertedTime" timestamp with time zone NOT NULL DEFAULT (now()),
        "MergedBy" character varying(200) NOT NULL DEFAULT '',
        "LastMergeTime" timestamp with time zone NOT NULL DEFAULT (now()),
        "LastModifiedTime" timestamp with time zone NOT NULL DEFAULT (now()),
        "LastHitTime" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity',
        "NetworkPolicyHash" character varying(128) NOT NULL DEFAULT '',
        "NetworkPolicy" jsonb NOT NULL,
        CONSTRAINT "PK_OldNetworkPolicyRecords" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "SetupThirdParties" (
        "Id" uuid NOT NULL,
        "Name" character varying(200) NOT NULL,
        "Description" character varying(1000),
        "ThirdPartyType" text,
        "TokenCanExpire" boolean NOT NULL,
        "Url" character varying(1024),
        "IsActive" boolean NOT NULL,
        "UserName" character varying(200),
        "Password" character varying(1000),
        "Token" character varying(2000),
        CONSTRAINT "PK_SetupThirdParties" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "AspNetRoleClaims" (
        "Id" integer GENERATED BY DEFAULT AS IDENTITY,
        "RoleId" text NOT NULL,
        "ClaimType" text,
        "ClaimValue" text,
        CONSTRAINT "PK_AspNetRoleClaims" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_AspNetRoleClaims_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "AspNetUserClaims" (
        "Id" integer GENERATED BY DEFAULT AS IDENTITY,
        "UserId" text NOT NULL,
        "ClaimType" text,
        "ClaimValue" text,
        CONSTRAINT "PK_AspNetUserClaims" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_AspNetUserClaims_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "AspNetUserLogins" (
        "LoginProvider" text NOT NULL,
        "ProviderKey" text NOT NULL,
        "ProviderDisplayName" text,
        "UserId" text NOT NULL,
        CONSTRAINT "PK_AspNetUserLogins" PRIMARY KEY ("LoginProvider", "ProviderKey"),
        CONSTRAINT "FK_AspNetUserLogins_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "AspNetUserRoles" (
        "UserId" text NOT NULL,
        "RoleId" text NOT NULL,
        CONSTRAINT "PK_AspNetUserRoles" PRIMARY KEY ("UserId", "RoleId"),
        CONSTRAINT "FK_AspNetUserRoles_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE,
        CONSTRAINT "FK_AspNetUserRoles_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "AspNetUserTokens" (
        "UserId" text NOT NULL,
        "LoginProvider" text NOT NULL,
        "Name" text NOT NULL,
        "Value" text,
        CONSTRAINT "PK_AspNetUserTokens" PRIMARY KEY ("UserId", "LoginProvider", "Name"),
        CONSTRAINT "FK_AspNetUserTokens_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "UserSettings" (
        "Id" uuid NOT NULL,
        "DefaultMode" text NOT NULL,
        "AppUserId" text NOT NULL,
        "NetworkPolicySettings" jsonb NOT NULL,
        "GenerateNetworkPolicyFlowConfig" jsonb NOT NULL,
        CONSTRAINT "PK_UserSettings" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_UserSettings_AspNetUsers_AppUserId" FOREIGN KEY ("AppUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "GitProviderSettings" (
        "Id" uuid NOT NULL,
        "UserSettingsId" uuid NOT NULL,
        CONSTRAINT "PK_GitProviderSettings" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_GitProviderSettings_UserSettings_UserSettingsId" FOREIGN KEY ("UserSettingsId") REFERENCES "UserSettings" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "TicketingProviderSettings" (
        "Id" uuid NOT NULL,
        "UserSettingsId" uuid NOT NULL,
        CONSTRAINT "PK_TicketingProviderSettings" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_TicketingProviderSettings_UserSettings_UserSettingsId" FOREIGN KEY ("UserSettingsId") REFERENCES "UserSettings" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "BitBucketProviderSettings" (
        "Id" uuid NOT NULL,
        "GitProviderSettingsId" uuid NOT NULL,
        "Username" character varying(100),
        "ApiToken" character varying(500),
        "DefaultWorkspace" character varying(100),
        "DefaultRepoSlug" character varying(100),
        "DefaultBaseBranch" character varying(100) NOT NULL DEFAULT 'main',
        "CreatedAt" timestamp with time zone,
        "UpdatedAt" timestamp with time zone,
        "RowVersion" bytea,
        CONSTRAINT "PK_BitBucketProviderSettings" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_BitBucketProviderSettings_GitProviderSettings_GitProviderSe~" FOREIGN KEY ("GitProviderSettingsId") REFERENCES "GitProviderSettings" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "GitHubProviderSettings" (
        "Id" uuid NOT NULL,
        "GitProviderSettingsId" uuid NOT NULL,
        "Token" character varying(500),
        "DefaultRepositoryOwner" character varying(100),
        "DefaultRepositoryName" character varying(100),
        "DefaultBaseBranch" character varying(100) NOT NULL DEFAULT 'main',
        "CreatedAt" timestamp with time zone,
        "UpdatedAt" timestamp with time zone,
        CONSTRAINT "PK_GitHubProviderSettings" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_GitHubProviderSettings_GitProviderSettings_GitProviderSetti~" FOREIGN KEY ("GitProviderSettingsId") REFERENCES "GitProviderSettings" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "GitLabProviderSettings" (
        "Id" uuid NOT NULL,
        "GitProviderSettingsId" uuid NOT NULL,
        "Token" character varying(500),
        "BaseUrl" character varying(200) NOT NULL DEFAULT 'https://gitlab.com',
        "DefaultProjectId" character varying(200),
        "DefaultBaseBranch" character varying(100) NOT NULL DEFAULT 'main',
        "CreatedAt" timestamp with time zone,
        "UpdatedAt" timestamp with time zone,
        CONSTRAINT "PK_GitLabProviderSettings" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_GitLabProviderSettings_GitProviderSettings_GitProviderSetti~" FOREIGN KEY ("GitProviderSettingsId") REFERENCES "GitProviderSettings" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "AzureDevOpsProviderSettings" (
        "Id" uuid NOT NULL,
        "TicketingProviderSettingsId" uuid NOT NULL,
        "OrganizationUrl" character varying(500),
        "PersonalAccessToken" character varying(500),
        "DefaultProject" character varying(200),
        "DefaultAreaPath" character varying(500),
        "DefaultIterationPath" character varying(500),
        "CreatedAt" timestamp with time zone,
        "UpdatedAt" timestamp with time zone,
        "RowVersion" bytea,
        CONSTRAINT "PK_AzureDevOpsProviderSettings" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_AzureDevOpsProviderSettings_TicketingProviderSettings_Ticke~" FOREIGN KEY ("TicketingProviderSettingsId") REFERENCES "TicketingProviderSettings" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "JiraProviderSettings" (
        "Id" uuid NOT NULL,
        "TicketingProviderSettingsId" uuid NOT NULL,
        "BaseUrl" character varying(500),
        "Email" character varying(200),
        "ApiToken" character varying(500),
        "DefaultProjectKey" character varying(100),
        "EpicLinkField" character varying(200),
        "CreatedAt" timestamp with time zone,
        "UpdatedAt" timestamp with time zone,
        "RowVersion" bytea,
        CONSTRAINT "PK_JiraProviderSettings" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_JiraProviderSettings_TicketingProviderSettings_TicketingPro~" FOREIGN KEY ("TicketingProviderSettingsId") REFERENCES "TicketingProviderSettings" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "LinearProviderSettings" (
        "Id" uuid NOT NULL,
        "TicketingProviderSettingsId" uuid NOT NULL,
        "ApiToken" character varying(500),
        "DefaultTeamId" character varying(200),
        "DefaultWorkflowStateId" character varying(200),
        "CreatedAt" timestamp with time zone,
        "UpdatedAt" timestamp with time zone,
        "RowVersion" bytea,
        CONSTRAINT "PK_LinearProviderSettings" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_LinearProviderSettings_TicketingProviderSettings_TicketingP~" FOREIGN KEY ("TicketingProviderSettingsId") REFERENCES "TicketingProviderSettings" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE TABLE "ServiceNowProviderSettings" (
        "Id" uuid NOT NULL,
        "TicketingProviderSettingsId" uuid NOT NULL,
        "InstanceUrl" character varying(500),
        "Username" character varying(200),
        "Password" character varying(500),
        "DefaultAssignmentGroup" character varying(200),
        "DefaultCategory" character varying(200),
        "CreatedAt" timestamp with time zone,
        "UpdatedAt" timestamp with time zone,
        "RowVersion" bytea,
        CONSTRAINT "PK_ServiceNowProviderSettings" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_ServiceNowProviderSettings_TicketingProviderSettings_Ticket~" FOREIGN KEY ("TicketingProviderSettingsId") REFERENCES "TicketingProviderSettings" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE INDEX "IX_AspNetRoleClaims_RoleId" ON "AspNetRoleClaims" ("RoleId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE UNIQUE INDEX "RoleNameIndex" ON "AspNetRoles" ("NormalizedName");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE INDEX "IX_AspNetUserClaims_UserId" ON "AspNetUserClaims" ("UserId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE INDEX "IX_AspNetUserLogins_UserId" ON "AspNetUserLogins" ("UserId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE INDEX "IX_AspNetUserRoles_RoleId" ON "AspNetUserRoles" ("RoleId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE INDEX "EmailIndex" ON "AspNetUsers" ("NormalizedEmail");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE UNIQUE INDEX "UserNameIndex" ON "AspNetUsers" ("NormalizedUserName");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE UNIQUE INDEX "IX_AzureDevOpsProviderSettings_TicketingProviderSettingsId" ON "AzureDevOpsProviderSettings" ("TicketingProviderSettingsId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE UNIQUE INDEX "IX_BitBucketProviderSettings_GitProviderSettingsId" ON "BitBucketProviderSettings" ("GitProviderSettingsId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE UNIQUE INDEX "IX_GitHubProviderSettings_GitProviderSettingsId" ON "GitHubProviderSettings" ("GitProviderSettingsId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE UNIQUE INDEX "IX_GitLabProviderSettings_GitProviderSettingsId" ON "GitLabProviderSettings" ("GitProviderSettingsId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE UNIQUE INDEX "IX_GitProviderSettings_UserSettingsId" ON "GitProviderSettings" ("UserSettingsId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE UNIQUE INDEX "IX_JiraProviderSettings_TicketingProviderSettingsId" ON "JiraProviderSettings" ("TicketingProviderSettingsId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE UNIQUE INDEX "IX_LinearProviderSettings_TicketingProviderSettingsId" ON "LinearProviderSettings" ("TicketingProviderSettingsId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE UNIQUE INDEX "IX_NetworkPolicyRecords_Name_Cluster" ON "NetworkPolicyRecords" ("Name", "ClusterName");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE UNIQUE INDEX "IX_OldNetworkPolicyRecords_Name_Cluster_Version" ON "OldNetworkPolicyRecords" ("Name", "ClusterName", "VersionNumber");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE UNIQUE INDEX "IX_ServiceNowProviderSettings_TicketingProviderSettingsId" ON "ServiceNowProviderSettings" ("TicketingProviderSettingsId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE UNIQUE INDEX "IX_SetupThirdParties_Name" ON "SetupThirdParties" ("Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE UNIQUE INDEX "IX_TicketingProviderSettings_UserSettingsId" ON "TicketingProviderSettings" ("UserSettingsId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    CREATE UNIQUE INDEX "IX_UserSettings_AppUserId" ON "UserSettings" ("AppUserId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260221180953_InitialCreateV2') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260221180953_InitialCreateV2', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260224092411_NamespaceAddedForRecords') THEN
    DROP INDEX "IX_OldNetworkPolicyRecords_Name_Cluster_Version";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260224092411_NamespaceAddedForRecords') THEN
    DROP INDEX "IX_NetworkPolicyRecords_Name_Cluster";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260224092411_NamespaceAddedForRecords') THEN
    ALTER TABLE "OldNetworkPolicyRecords" ADD "Namespace" character varying(200) NOT NULL DEFAULT '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260224092411_NamespaceAddedForRecords') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "Namespace" character varying(200) NOT NULL DEFAULT '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260224092411_NamespaceAddedForRecords') THEN
    CREATE UNIQUE INDEX "IX_OldNetworkPolicyRecords_Name_Cluster_Namespace_Version" ON "OldNetworkPolicyRecords" ("Name", "ClusterName", "Namespace", "VersionNumber");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260224092411_NamespaceAddedForRecords') THEN
    CREATE UNIQUE INDEX "IX_NetworkPolicyRecords_Name_Cluster_Namespace" ON "NetworkPolicyRecords" ("Name", "ClusterName", "Namespace");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260224092411_NamespaceAddedForRecords') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260224092411_NamespaceAddedForRecords', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260317125815_ExclusionListAdded') THEN
    ALTER TABLE "UserSettings" ADD "ExclusionList" jsonb NOT NULL DEFAULT ('{"WildcardNamespaces":[],"SpecificNamespaces":[]}'::jsonb);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260317125815_ExclusionListAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260317125815_ExclusionListAdded', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260317135613_ExclusionListUpdated') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260317135613_ExclusionListUpdated', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260318070959_ExclusionListUpdated2') THEN
    ALTER TABLE "UserSettings" ALTER COLUMN "ExclusionList" SET DEFAULT ('{"WildcardNamespaces":[],"SpecificNamespaces":[],"GlobalWildcardNamespaces":[]}'::jsonb);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260318070959_ExclusionListUpdated2') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260318070959_ExclusionListUpdated2', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260327111300_GlobalWhitelistPoliciesAdded') THEN
    CREATE TABLE "GlobalWhitelistPolicies" (
        "Id" uuid NOT NULL,
        "Name" character varying(200) NOT NULL,
        "Description" text,
        "Policy" jsonb NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_GlobalWhitelistPolicies" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260327111300_GlobalWhitelistPoliciesAdded') THEN
    CREATE UNIQUE INDEX "IX_GlobalWhitelistPolicies_Name" ON "GlobalWhitelistPolicies" ("Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260327111300_GlobalWhitelistPoliciesAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260327111300_GlobalWhitelistPoliciesAdded', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260327123046_GlobalWhitelistJsonRemoved') THEN
    ALTER TABLE "GlobalWhitelistPolicies" ALTER COLUMN "Policy" TYPE text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260327123046_GlobalWhitelistJsonRemoved') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260327123046_GlobalWhitelistJsonRemoved', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260331083546_LDAPIntegrationAdded') THEN
    ALTER TABLE "AspNetUsers" ADD "FirstName" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260331083546_LDAPIntegrationAdded') THEN
    ALTER TABLE "AspNetUsers" ADD "IsADUser" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260331083546_LDAPIntegrationAdded') THEN
    ALTER TABLE "AspNetUsers" ADD "IsDisabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260331083546_LDAPIntegrationAdded') THEN
    ALTER TABLE "AspNetUsers" ADD "LastName" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260331083546_LDAPIntegrationAdded') THEN
    CREATE TABLE "ADRoleMappings" (
        "Id" uuid NOT NULL,
        "ADGroupName" text NOT NULL,
        "ApplicationRole" text NOT NULL,
        CONSTRAINT "PK_ADRoleMappings" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260331083546_LDAPIntegrationAdded') THEN
    CREATE TABLE "LDAPConnections" (
        "Id" uuid NOT NULL,
        "DomainName" text NOT NULL,
        "Port" integer NOT NULL,
        "BindAccount" text NOT NULL,
        "BindPassword" text NOT NULL,
        "UseSsl" boolean NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_LDAPConnections" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260331083546_LDAPIntegrationAdded') THEN
    CREATE TABLE "LicenseInfos" (
        "Id" uuid NOT NULL,
        "LicenseKey" text NOT NULL,
        "ExpirationDate" timestamp with time zone NOT NULL,
        "IsActive" boolean NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "ActivatedAt" timestamp with time zone,
        CONSTRAINT "PK_LicenseInfos" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260331083546_LDAPIntegrationAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260331083546_LDAPIntegrationAdded', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260401134343_LDAPRoleMappingRelationAdded') THEN
    ALTER TABLE "ADRoleMappings" ADD "LdapConnectionId" uuid NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260401134343_LDAPRoleMappingRelationAdded') THEN
    CREATE INDEX "IX_ADRoleMappings_LdapConnectionId" ON "ADRoleMappings" ("LdapConnectionId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260401134343_LDAPRoleMappingRelationAdded') THEN
    ALTER TABLE "ADRoleMappings" ADD CONSTRAINT "FK_ADRoleMappings_LDAPConnections_LdapConnectionId" FOREIGN KEY ("LdapConnectionId") REFERENCES "LDAPConnections" ("Id") ON DELETE CASCADE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260401134343_LDAPRoleMappingRelationAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260401134343_LDAPRoleMappingRelationAdded', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260401142254_LDAPRoleMappingRelationUpdated') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260401142254_LDAPRoleMappingRelationUpdated', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260408104731_GitSharedVariableAdded') THEN
    ALTER TABLE "GitProviderSettings" ADD "Shared" boolean NOT NULL DEFAULT TRUE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260408104731_GitSharedVariableAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260408104731_GitSharedVariableAdded', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260413112347_NPWatcherSettingsAdded') THEN
    CREATE TABLE "WatcherSettings" (
        "Id" uuid NOT NULL,
        "IsEnabled" boolean NOT NULL DEFAULT FALSE,
        "AddedEventAction" integer NOT NULL DEFAULT 1,
        "ModifiedEventAction" integer NOT NULL DEFAULT 2,
        "DeletedEventAction" integer NOT NULL DEFAULT 2,
        CONSTRAINT "PK_WatcherSettings" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260413112347_NPWatcherSettingsAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260413112347_NPWatcherSettingsAdded', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260413112818_NPWatcherSettingsAdded2') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260413112818_NPWatcherSettingsAdded2', '10.0.5');
    END IF;
END $EF$;
COMMIT;
START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508075252_LicenseInfoExtended') THEN
    ALTER TABLE "LicenseInfos" ADD "ClusterUid" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508075252_LicenseInfoExtended') THEN
    ALTER TABLE "LicenseInfos" ADD "Customer" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508075252_LicenseInfoExtended') THEN
    ALTER TABLE "LicenseInfos" ADD "IssuedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508075252_LicenseInfoExtended') THEN
    ALTER TABLE "LicenseInfos" ADD "IssuedBy" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508075252_LicenseInfoExtended') THEN
    ALTER TABLE "LicenseInfos" ADD "LastObservedNodeCount" integer;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508075252_LicenseInfoExtended') THEN
    ALTER TABLE "LicenseInfos" ADD "LastValidatedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508075252_LicenseInfoExtended') THEN
    ALTER TABLE "LicenseInfos" ADD "MaxWorkerNodes" integer NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508075252_LicenseInfoExtended') THEN
    ALTER TABLE "LicenseInfos" ADD "ValidationStatus" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508075252_LicenseInfoExtended') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260508075252_LicenseInfoExtended', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508113341_PolicyHitAnalytics') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "HitCount" bigint NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508113341_PolicyHitAnalytics') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "LastHitDirection" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508113341_PolicyHitAnalytics') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "LastHitRuleIndex" integer;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508113341_PolicyHitAnalytics') THEN
    CREATE TABLE "AnalyticsSettings" (
        "Id" uuid NOT NULL,
        "StaleThresholdDays" integer NOT NULL,
        "GraceDays" integer NOT NULL,
        "AllowPolicyDeletion" boolean NOT NULL,
        CONSTRAINT "PK_AnalyticsSettings" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508113341_PolicyHitAnalytics') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260508113341_PolicyHitAnalytics', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508121319_AnalyticsScopeOptIn') THEN
    ALTER TABLE "AnalyticsSettings" ADD "Enabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508121319_AnalyticsScopeOptIn') THEN
    CREATE TABLE "AnalyticsTrackedScopes" (
        "Id" uuid NOT NULL,
        "ClusterName" text NOT NULL,
        "Namespace" text,
        "CreatedAt" timestamp with time zone NOT NULL,
        "Note" text,
        CONSTRAINT "PK_AnalyticsTrackedScopes" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260508121319_AnalyticsScopeOptIn') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260508121319_AnalyticsScopeOptIn', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260511120000_MonitoredClusterNodeTelemetry') THEN
    ALTER TABLE "SetupThirdParties" ADD "ClusterUid" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260511120000_MonitoredClusterNodeTelemetry') THEN
    ALTER TABLE "SetupThirdParties" ADD "LastObservedNodeCount" integer;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260511120000_MonitoredClusterNodeTelemetry') THEN
    ALTER TABLE "SetupThirdParties" ADD "LastNodeCheckAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260511120000_MonitoredClusterNodeTelemetry') THEN
    ALTER TABLE "SetupThirdParties" ADD "LastNodeCheckError" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260511120000_MonitoredClusterNodeTelemetry') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260511120000_MonitoredClusterNodeTelemetry', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512000000_AnalyticsAuditLog') THEN
    CREATE TABLE "AnalyticsAuditEntries" (
        "Id" uuid NOT NULL,
        "At" timestamp with time zone NOT NULL,
        "Actor" text NULL,
        "Action" text NOT NULL,
        "Summary" text NOT NULL,
        "Details" text NULL,
        CONSTRAINT "PK_AnalyticsAuditEntries" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512000000_AnalyticsAuditLog') THEN
    CREATE INDEX "IX_AnalyticsAuditEntries_At" ON "AnalyticsAuditEntries" ("At");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512000000_AnalyticsAuditLog') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260512000000_AnalyticsAuditLog', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512100000_PolicyHitDaily') THEN
    CREATE TABLE "PolicyHitDaily" (
        "PolicyRecordId" uuid NOT NULL,
        "Day" timestamp with time zone NOT NULL,
        "Count" bigint NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_PolicyHitDaily" PRIMARY KEY ("PolicyRecordId", "Day")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512100000_PolicyHitDaily') THEN
    CREATE INDEX "IX_PolicyHitDaily_Day" ON "PolicyHitDaily" ("Day");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512100000_PolicyHitDaily') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260512100000_PolicyHitDaily', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512200000_AnalyticsOverhaul') THEN
    CREATE TABLE "AnalyticsSavedViews" (
        "Id" uuid NOT NULL,
        "Name" text NOT NULL,
        "OwnerUserId" text NOT NULL,
        "IsShared" boolean NOT NULL,
        "FiltersJson" text NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_AnalyticsSavedViews" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512200000_AnalyticsOverhaul') THEN
    CREATE INDEX "IX_AnalyticsSavedViews_OwnerUserId" ON "AnalyticsSavedViews" ("OwnerUserId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512200000_AnalyticsOverhaul') THEN
    CREATE TABLE "AnalyticsAlertRules" (
        "Id" uuid NOT NULL,
        "Name" text NOT NULL,
        "OwnerUserId" text NOT NULL,
        "ClusterId" text NOT NULL DEFAULT '',
        "MetricKind" text NOT NULL,
        "Operator" text NOT NULL,
        "Threshold" double precision NOT NULL,
        "WindowMinutes" integer NOT NULL,
        "Enabled" boolean NOT NULL,
        "LastEvaluatedAt" timestamp with time zone NULL,
        "LastTriggeredAt" timestamp with time zone NULL,
        "LastValue" double precision NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_AnalyticsAlertRules" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512200000_AnalyticsOverhaul') THEN
    CREATE INDEX "IX_AnalyticsAlertRules_OwnerUserId" ON "AnalyticsAlertRules" ("OwnerUserId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512200000_AnalyticsOverhaul') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260512200000_AnalyticsOverhaul', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512300000_AnalyticsAlertWebhook') THEN
    ALTER TABLE "AnalyticsAlertRules" ADD "WebhookUrl" text NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512300000_AnalyticsAlertWebhook') THEN
    ALTER TABLE "AnalyticsAlertRules" ADD "WebhookKind" text NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512300000_AnalyticsAlertWebhook') THEN
    ALTER TABLE "AnalyticsAlertRules" ADD "LastDeliveryAt" timestamp with time zone NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512300000_AnalyticsAlertWebhook') THEN
    ALTER TABLE "AnalyticsAlertRules" ADD "LastDeliveryOk" boolean NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512300000_AnalyticsAlertWebhook') THEN
    ALTER TABLE "AnalyticsAlertRules" ADD "LastDeliveryError" text NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512300000_AnalyticsAlertWebhook') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260512300000_AnalyticsAlertWebhook', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260513080000_AnalyticsPolishWaveTwo') THEN
    ALTER TABLE "AnalyticsAlertRules" ADD "SuppressMinutes" integer NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260513080000_AnalyticsPolishWaveTwo') THEN
    ALTER TABLE "AnalyticsAlertRules" ADD "SuppressUntil" timestamp with time zone NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260513080000_AnalyticsPolishWaveTwo') THEN
    ALTER TABLE "AnalyticsSavedViews" ADD "DigestRecipients" text NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260513080000_AnalyticsPolishWaveTwo') THEN
    ALTER TABLE "AnalyticsSavedViews" ADD "DigestCron" text NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260513080000_AnalyticsPolishWaveTwo') THEN
    ALTER TABLE "AnalyticsSavedViews" ADD "LastDigestSentAt" timestamp with time zone NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260513080000_AnalyticsPolishWaveTwo') THEN
    ALTER TABLE "AnalyticsSavedViews" ADD "LastDigestOk" boolean NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260513080000_AnalyticsPolishWaveTwo') THEN
    ALTER TABLE "AnalyticsSavedViews" ADD "LastDigestError" text NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260513080000_AnalyticsPolishWaveTwo') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260513080000_AnalyticsPolishWaveTwo', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260513090000_AnalyticsAlertSeverity') THEN
    ALTER TABLE "AnalyticsAlertRules" ADD "Severity" text NOT NULL DEFAULT 'medium';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260513090000_AnalyticsAlertSeverity') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260513090000_AnalyticsAlertSeverity', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260514000000_OpenShiftSso') THEN
    ALTER TABLE "AspNetUsers" ADD "IsOcpUser" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260514000000_OpenShiftSso') THEN
    CREATE TABLE "OpenShiftIntegrations" (
        "Id" uuid NOT NULL,
        "DisplayName" text NOT NULL,
        "AuthorizeUrl" text NOT NULL,
        "TokenUrl" text NOT NULL,
        "UserInfoUrl" text NOT NULL,
        "ClientId" text NOT NULL,
        "ClientSecret" text NOT NULL,
        "DefaultRole" text NOT NULL,
        "IsEnabled" boolean NOT NULL DEFAULT TRUE,
        "CreatedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_OpenShiftIntegrations" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260514000000_OpenShiftSso') THEN
    CREATE TABLE "OcpGroupMappings" (
        "Id" uuid NOT NULL,
        "OcpGroupName" text NOT NULL,
        "ApplicationRole" text NOT NULL,
        "OpenShiftIntegrationId" uuid NOT NULL,
        CONSTRAINT "PK_OcpGroupMappings" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_OcpGroupMappings_OpenShiftIntegrations_OpenShiftIntegrationId"
            FOREIGN KEY ("OpenShiftIntegrationId")
            REFERENCES "OpenShiftIntegrations" ("Id")
            ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260514000000_OpenShiftSso') THEN
    CREATE INDEX "IX_OcpGroupMappings_OpenShiftIntegrationId" ON "OcpGroupMappings" ("OpenShiftIntegrationId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260514000000_OpenShiftSso') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260514000000_OpenShiftSso', '10.0.5');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    CREATE TABLE "CustomRoles" (
        "Id" uuid NOT NULL,
        "Name" text NOT NULL,
        "Description" text NULL,
        "IsBuiltIn" boolean NOT NULL DEFAULT FALSE,
        "CreatedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_CustomRoles" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    CREATE UNIQUE INDEX "IX_CustomRoles_Name" ON "CustomRoles" ("Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    CREATE TABLE "CustomRolePermissions" (
        "Id" uuid NOT NULL,
        "CustomRoleId" uuid NOT NULL,
        "Resource" text NOT NULL,
        "Scope" text NOT NULL,
        CONSTRAINT "PK_CustomRolePermissions" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_CustomRolePermissions_CustomRoles_CustomRoleId"
            FOREIGN KEY ("CustomRoleId")
            REFERENCES "CustomRoles" ("Id")
            ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    CREATE UNIQUE INDEX "IX_CustomRolePermissions_CustomRoleId_Resource_Scope"
        ON "CustomRolePermissions" ("CustomRoleId", "Resource", "Scope");
    END IF;
END $EF$;

-- ---- Seed built-in roles ----
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRoles" ("Id", "Name", "Description", "IsBuiltIn", "CreatedAt", "UpdatedAt")
    VALUES
        ('00000001-0000-0000-0000-000000000001', 'Admin', 'Full administrative control across all resources.', TRUE, TIMESTAMPTZ '2026-05-15 00:00:00Z', TIMESTAMPTZ '2026-05-15 00:00:00Z'),
        ('00000002-0000-0000-0000-000000000002', 'NetworkOperator', 'Manages network policies, integrations, and operational settings; cannot touch user/role administration.', TRUE, TIMESTAMPTZ '2026-05-15 00:00:00Z', TIMESTAMPTZ '2026-05-15 00:00:00Z'),
        ('00000003-0000-0000-0000-000000000003', 'Auditor', 'Read-only visibility across operational data and analytics.', TRUE, TIMESTAMPTZ '2026-05-15 00:00:00Z', TIMESTAMPTZ '2026-05-15 00:00:00Z'),
        ('00000004-0000-0000-0000-000000000004', 'AccessUser', 'Personal dashboard access only; no admin or operational permissions.', TRUE, TIMESTAMPTZ '2026-05-15 00:00:00Z', TIMESTAMPTZ '2026-05-15 00:00:00Z');
    END IF;
END $EF$;

-- ---- Seed permissions (mirror of Persistence/Migrations/20260515000000_CustomRoleBuilder.cs Grants) ----
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope") VALUES
        -- Admin
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'NetworkPolicy', 'Read'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'NetworkPolicy', 'Write'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'NetworkPolicy', 'Delete'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'GlobalWhitelistPolicy', 'Read'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'GlobalWhitelistPolicy', 'Write'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'GlobalWhitelistPolicy', 'Delete'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'GitProviderSettings', 'Manage'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'TicketingProviderSettings', 'Manage'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'LdapConnection', 'Manage'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'OpenShiftIntegration', 'Manage'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'License', 'Read'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'License', 'Write'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'SetupThirdParty', 'Read'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'SetupThirdParty', 'Write'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'SetupThirdParty', 'Delete'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'UserManagement', 'Manage'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'UserSettings', 'Read'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'UserSettings', 'Write'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'KubernetesPush', 'Write'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'NetworkPolicyFlow', 'Write'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'Jira', 'Read'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'Jira', 'Write'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'Proxy', 'Read'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'RadarFlow', 'Read'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'RadarCollection', 'Read'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'RadarCollection', 'Write'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'RadarCollection', 'Delete'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'AllowDropMonitor', 'Read'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'Settings', 'Read'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'Settings', 'Write'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'WatcherSettings', 'Read'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'WatcherSettings', 'Write'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'Analytics', 'Read'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'Analytics', 'Write'),
        (gen_random_uuid(), '00000001-0000-0000-0000-000000000001', 'Analytics', 'Delete'),
        -- NetworkOperator
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'NetworkPolicy', 'Read'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'NetworkPolicy', 'Write'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'NetworkPolicy', 'Delete'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'GlobalWhitelistPolicy', 'Read'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'GlobalWhitelistPolicy', 'Write'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'GlobalWhitelistPolicy', 'Delete'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'GitProviderSettings', 'Manage'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'TicketingProviderSettings', 'Manage'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'SetupThirdParty', 'Read'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'UserSettings', 'Read'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'UserSettings', 'Write'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'KubernetesPush', 'Write'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'NetworkPolicyFlow', 'Write'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'Jira', 'Read'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'Jira', 'Write'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'Proxy', 'Read'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'RadarFlow', 'Read'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'RadarCollection', 'Read'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'RadarCollection', 'Write'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'RadarCollection', 'Delete'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'AllowDropMonitor', 'Read'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'Settings', 'Read'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'WatcherSettings', 'Read'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'Analytics', 'Read'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'Analytics', 'Write'),
        (gen_random_uuid(), '00000002-0000-0000-0000-000000000002', 'Analytics', 'Delete'),
        -- Auditor
        (gen_random_uuid(), '00000003-0000-0000-0000-000000000003', 'SetupThirdParty', 'Read'),
        (gen_random_uuid(), '00000003-0000-0000-0000-000000000003', 'UserSettings', 'Read'),
        (gen_random_uuid(), '00000003-0000-0000-0000-000000000003', 'UserSettings', 'Write'),
        (gen_random_uuid(), '00000003-0000-0000-0000-000000000003', 'Jira', 'Read'),
        (gen_random_uuid(), '00000003-0000-0000-0000-000000000003', 'Proxy', 'Read'),
        (gen_random_uuid(), '00000003-0000-0000-0000-000000000003', 'RadarFlow', 'Read'),
        (gen_random_uuid(), '00000003-0000-0000-0000-000000000003', 'RadarCollection', 'Read'),
        (gen_random_uuid(), '00000003-0000-0000-0000-000000000003', 'AllowDropMonitor', 'Read'),
        (gen_random_uuid(), '00000003-0000-0000-0000-000000000003', 'WatcherSettings', 'Read'),
        (gen_random_uuid(), '00000003-0000-0000-0000-000000000003', 'Analytics', 'Read'),
        -- AccessUser
        (gen_random_uuid(), '00000004-0000-0000-0000-000000000004', 'SetupThirdParty', 'Read'),
        (gen_random_uuid(), '00000004-0000-0000-0000-000000000004', 'UserSettings', 'Read'),
        (gen_random_uuid(), '00000004-0000-0000-0000-000000000004', 'UserSettings', 'Write'),
        (gen_random_uuid(), '00000004-0000-0000-0000-000000000004', 'Proxy', 'Read'),
        (gen_random_uuid(), '00000004-0000-0000-0000-000000000004', 'RadarFlow', 'Read'),
        (gen_random_uuid(), '00000004-0000-0000-0000-000000000004', 'RadarCollection', 'Read'),
        (gen_random_uuid(), '00000004-0000-0000-0000-000000000004', 'AllowDropMonitor', 'Read'),
        (gen_random_uuid(), '00000004-0000-0000-0000-000000000004', 'WatcherSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260515000000_CustomRoleBuilder', '10.0.5');
    END IF;
END $EF$;
COMMIT;

-- =============================================================================
-- 20260521000000_AuditOverhaul
-- Unified product-wide audit log (AuditEntries) + SIEM forwarding config
-- (SiemSettings). Copies legacy AnalyticsAuditEntries rows over with
-- Category='Analytics'. Seeds Audit grants for the four built-in roles so
-- the new menu entries are reachable out of the box.
-- =============================================================================

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521000000_AuditOverhaul') THEN
    CREATE TABLE "AuditEntries" (
        "Id" uuid NOT NULL,
        "At" timestamp with time zone NOT NULL,
        "Actor" text NULL,
        "Category" text NOT NULL,
        "Action" text NOT NULL,
        "Summary" text NOT NULL,
        "Details" text NULL,
        "ForwardedAt" timestamp with time zone NULL,
        CONSTRAINT "PK_AuditEntries" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521000000_AuditOverhaul') THEN
    CREATE INDEX "IX_AuditEntries_At" ON "AuditEntries" ("At");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521000000_AuditOverhaul') THEN
    CREATE INDEX "IX_AuditEntries_Category" ON "AuditEntries" ("Category");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521000000_AuditOverhaul') THEN
    CREATE INDEX "IX_AuditEntries_ForwardedAt_pending"
        ON "AuditEntries" ("At")
        WHERE "ForwardedAt" IS NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521000000_AuditOverhaul') THEN
    CREATE TABLE "SiemSettings" (
        "Id" uuid NOT NULL,
        "Enabled" boolean NOT NULL,
        "Protocol" integer NOT NULL,
        "EndpointUrl" text NULL,
        "Token" text NULL,
        "Index" text NULL,
        "SyslogHost" text NULL,
        "SyslogPort" integer NULL,
        "AppName" text NULL,
        "ForwardAuditLogs" boolean NOT NULL,
        "ForwardPolicyMonitoringLogs" boolean NOT NULL,
        "AllowInsecureTls" boolean NOT NULL,
        "RetentionDays" integer NOT NULL DEFAULT 90,
        "PolicyMonitoringForwardedThrough" timestamp with time zone NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" text NULL,
        CONSTRAINT "PK_SiemSettings" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

-- Backfill: every existing analytics audit row gets a copy in the unified
-- table with Category='Analytics'. Old table stays in place so legacy
-- /api/analytics/audit endpoints keep working. The IF NOT EXISTS on the
-- migration-history gate makes the whole backfill idempotent.
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521000000_AuditOverhaul') THEN
    IF EXISTS (
        SELECT 1 FROM information_schema.tables
        WHERE table_schema = 'public' AND table_name = 'AnalyticsAuditEntries'
    ) THEN
        INSERT INTO "AuditEntries" ("Id", "At", "Actor", "Category", "Action", "Summary", "Details", "ForwardedAt")
        SELECT "Id", "At", "Actor", 'Analytics', "Action", "Summary", "Details", NULL
        FROM "AnalyticsAuditEntries"
        ON CONFLICT DO NOTHING;
    END IF;
    END IF;
END $EF$;

-- Grant the Audit resource to the seeded built-in roles. Without this
-- every menu item gated on Audit.Read/Manage stays hidden â€” the Audit
-- page would exist but be unreachable.
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521000000_AuditOverhaul') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    SELECT gen_random_uuid(), g.role_id, 'Audit', g.scope
    FROM (VALUES
        ('00000001-0000-0000-0000-000000000001'::uuid, 'Manage'), -- Admin
        ('00000002-0000-0000-0000-000000000002'::uuid, 'Read'),   -- NetworkOperator
        ('00000003-0000-0000-0000-000000000003'::uuid, 'Read')    -- Auditor
    ) AS g(role_id, scope)
    WHERE NOT EXISTS (
        SELECT 1 FROM "CustomRolePermissions" p
        WHERE p."CustomRoleId" = g.role_id
          AND p."Resource"     = 'Audit'
          AND p."Scope"        = g.scope
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521000000_AuditOverhaul') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260521000000_AuditOverhaul', '10.0.5');
    END IF;
END $EF$;
COMMIT;

-- =============================================================================
-- 20260521020000_SiemRetention
-- Adds SiemSettings.RetentionDays for clusters that already ran AuditOverhaul
-- against an older schema (no RetentionDays in the CREATE TABLE). Fresh
-- installs running AuditOverhaul *with* the column see IF NOT EXISTS make
-- this an idempotent no-op.
-- =============================================================================

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521020000_SiemRetention') THEN
    ALTER TABLE "SiemSettings"
        ADD COLUMN IF NOT EXISTS "RetentionDays" integer NOT NULL DEFAULT 90;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521020000_SiemRetention') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260521020000_SiemRetention', '10.0.5');
    END IF;
END $EF$;
COMMIT;

-- =============================================================================
-- 20260521030000_SiemCategoryFilter
-- Optional per-category SIEM forwarding allow-list. NULL = forward all
-- categories (back-compat), populated text[] = only those tags.
-- =============================================================================

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521030000_SiemCategoryFilter') THEN
    ALTER TABLE "SiemSettings"
        ADD COLUMN IF NOT EXISTS "ForwardedAuditCategories" text[];
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521030000_SiemCategoryFilter') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260521030000_SiemCategoryFilter', '10.0.5');
    END IF;
END $EF$;
COMMIT;

-- =============================================================================
-- 20260522000000_IncidentsAndThreatIntel
-- Stand-up of the Incidents pipeline + threat-intel configuration.
--   * SiemSettings gains ForwardIncidents (default TRUE) and an
--     IncidentsForwardedThrough watermark used by SiemForwarderHostedService.
--   * New tables: Incidents, IncidentEvents (FK cascade), ThreatIntelSettings
--     (singleton), ThreatIntelFeeds (per-feed config).
--   * Seeds four built-in opensource feeds (FireHOL Level1, Feodo Tracker,
--     URLhaus, Tor exit) and the ThreatIntelSettings singleton row so the
--     admin UI lands on real values instead of an empty form.
--   * Grants Incident + ThreatIntel resources to the built-in roles
--     (Admin = Manage, NetworkOperator + Auditor = Read), mirroring the
--     pattern AuditOverhaul used for the Audit resource.
-- =============================================================================

START TRANSACTION;

-- ---- SiemSettings: incident-stream toggle + watermark ----------------------

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    ALTER TABLE "SiemSettings"
        ADD COLUMN IF NOT EXISTS "ForwardIncidents" boolean NOT NULL DEFAULT TRUE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    ALTER TABLE "SiemSettings"
        ADD COLUMN IF NOT EXISTS "IncidentsForwardedThrough" timestamp with time zone;
    END IF;
END $EF$;

-- ---- Incidents -------------------------------------------------------------

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    CREATE TABLE IF NOT EXISTS "Incidents" (
        "Id" uuid NOT NULL,
        "FirstSeenAt" timestamp with time zone NOT NULL,
        "LastSeenAt" timestamp with time zone NOT NULL,
        "Detector" character varying(64) NOT NULL,
        "Severity" integer NOT NULL,
        "Status" integer NOT NULL,
        "Title" character varying(512) NOT NULL,
        "CorrelationKey" character varying(512) NOT NULL,
        "ClusterName" character varying(256),
        "SrcNamespace" character varying(256),
        "SrcWorkload" character varying(256),
        "DstIp" character varying(64),
        "DstHost" character varying(512),
        "DstPort" integer NOT NULL,
        "ThreatIntelSources" character varying(512),
        "EventCount" integer NOT NULL DEFAULT 1,
        "Notes" text,
        "ForwardedAt" timestamp with time zone,
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" character varying(256),
        CONSTRAINT "PK_Incidents" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    CREATE INDEX IF NOT EXISTS "IX_Incidents_CorrelationKey_Active"
        ON "Incidents" ("CorrelationKey");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    CREATE INDEX IF NOT EXISTS "IX_Incidents_LastSeenAt"
        ON "Incidents" ("LastSeenAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    CREATE INDEX IF NOT EXISTS "IX_Incidents_ForwardedAt"
        ON "Incidents" ("ForwardedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    CREATE TABLE IF NOT EXISTS "IncidentEvents" (
        "Id" uuid NOT NULL,
        "IncidentId" uuid NOT NULL,
        "At" timestamp with time zone NOT NULL,
        "Payload" text,
        CONSTRAINT "PK_IncidentEvents" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_IncidentEvents_Incidents_IncidentId"
            FOREIGN KEY ("IncidentId") REFERENCES "Incidents" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    CREATE INDEX IF NOT EXISTS "IX_IncidentEvents_Incident_At"
        ON "IncidentEvents" ("IncidentId", "At");
    END IF;
END $EF$;

-- ---- ThreatIntelSettings (singleton) ---------------------------------------

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    CREATE TABLE IF NOT EXISTS "ThreatIntelSettings" (
        "Id" uuid NOT NULL,
        "Enabled" boolean NOT NULL,
        "IpReputationEnabled" boolean NOT NULL,
        "DnsThreatEnabled" boolean NOT NULL,
        "LateralMovementEnabled" boolean NOT NULL,
        "VirusTotalApiKey" character varying(512),
        "AbuseIpDbApiKey" character varying(512),
        "OtxApiKey" character varying(512),
        "MispBaseUrl" character varying(512),
        "MispAuthKey" character varying(512),
        "AllowInsecureTls" boolean NOT NULL,
        "ProviderHighSeverityThreshold" integer NOT NULL DEFAULT 50,
        "CorrelationWindowMinutes" integer NOT NULL DEFAULT 15,
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" character varying(256),
        CONSTRAINT "PK_ThreatIntelSettings" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

-- ---- ThreatIntelFeeds ------------------------------------------------------

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    CREATE TABLE IF NOT EXISTS "ThreatIntelFeeds" (
        "Id" uuid NOT NULL,
        "Key" character varying(64) NOT NULL,
        "DisplayName" character varying(256) NOT NULL,
        "Kind" integer NOT NULL,
        "Url" character varying(1024) NOT NULL,
        "Enabled" boolean NOT NULL,
        "IsBuiltIn" boolean NOT NULL,
        "LastRefreshedAt" timestamp with time zone,
        "EntryCount" integer NOT NULL,
        "LastError" character varying(1024),
        "CreatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_ThreatIntelFeeds" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    CREATE UNIQUE INDEX IF NOT EXISTS "IX_ThreatIntelFeeds_Key"
        ON "ThreatIntelFeeds" ("Key");
    END IF;
END $EF$;

-- ---- Seed: four built-in feeds (idempotent via ON CONFLICT on Key) --------
-- Air-gapped customers can override Url after install; Enabled stays toggle-able.
-- Tor exit is shipped disabled because legitimate Tor egress is common in
-- some environments â€” flip it on in Admin â†’ Threat Intel when policy says so.

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    INSERT INTO "ThreatIntelFeeds"
        ("Id", "Key", "DisplayName", "Kind", "Url", "Enabled", "IsBuiltIn", "EntryCount", "CreatedAt")
    VALUES
        (gen_random_uuid(), 'firehol-level1', 'FireHOL Level1 (high-confidence malicious networks)', 0,
         'https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level1.netset',
         TRUE, TRUE, 0, now()),
        (gen_random_uuid(), 'feodo-tracker', 'abuse.ch Feodo Tracker (active botnet C2)', 0,
         'https://feodotracker.abuse.ch/downloads/ipblocklist.txt',
         TRUE, TRUE, 0, now()),
        (gen_random_uuid(), 'urlhaus', 'abuse.ch URLhaus (malware-hosting domains)', 1,
         'https://urlhaus.abuse.ch/downloads/text/',
         TRUE, TRUE, 0, now()),
        (gen_random_uuid(), 'tor-exit', 'Tor Project exit-node list', 0,
         'https://check.torproject.org/torbulkexitlist',
         FALSE, TRUE, 0, now())
    ON CONFLICT ("Key") DO NOTHING;
    END IF;
END $EF$;

-- ---- Seed: ThreatIntelSettings singleton -----------------------------------

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    INSERT INTO "ThreatIntelSettings"
        ("Id", "Enabled", "IpReputationEnabled", "DnsThreatEnabled",
         "LateralMovementEnabled", "AllowInsecureTls",
         "ProviderHighSeverityThreshold", "CorrelationWindowMinutes",
         "UpdatedAt")
    SELECT gen_random_uuid(), TRUE, TRUE, TRUE, TRUE, FALSE, 50, 15, now()
    WHERE NOT EXISTS (SELECT 1 FROM "ThreatIntelSettings");
    END IF;
END $EF$;

-- ---- RBAC: grant Incident + ThreatIntel on the built-in roles --------------
-- Mirrors AuditOverhaul.cs / CustomRoleBuilder seeds. Stable role ids match
-- those earlier migrations. NOT EXISTS guards keep replays idempotent.

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    SELECT gen_random_uuid(), g.role_id, g.resource, g.scope
    FROM (VALUES
        ('00000001-0000-0000-0000-000000000001'::uuid, 'Incident',    'Manage'),
        ('00000001-0000-0000-0000-000000000001'::uuid, 'ThreatIntel', 'Manage'),
        ('00000002-0000-0000-0000-000000000002'::uuid, 'Incident',    'Read'),
        ('00000002-0000-0000-0000-000000000002'::uuid, 'ThreatIntel', 'Read'),
        ('00000003-0000-0000-0000-000000000003'::uuid, 'Incident',    'Read'),
        ('00000003-0000-0000-0000-000000000003'::uuid, 'ThreatIntel', 'Read')
    ) AS g(role_id, resource, scope)
    WHERE NOT EXISTS (
        SELECT 1 FROM "CustomRolePermissions" p
        WHERE p."CustomRoleId" = g.role_id
          AND p."Resource"     = g.resource
          AND p."Scope"        = g.scope
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260522000000_IncidentsAndThreatIntel', '10.0.5');
    END IF;
END $EF$;
COMMIT;

-- =============================================================================
-- 20260523000000_ThreatIntelExclusions
-- Operational gate the detection pipeline consults before any detector
-- runs. One row = "ignore (cluster, namespace, workload)" â€” Kind=0 covers
-- the whole namespace, Kind=1 narrows to one workload; Cluster=NULL means
-- cluster-wide. Collection-grouped exclusions live as multiple rows
-- sharing a Source tag (frontend expands at write time).
-- =============================================================================

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260523000000_ThreatIntelExclusions') THEN
    CREATE TABLE IF NOT EXISTS "ThreatIntelExclusions" (
        "Id" uuid NOT NULL,
        "Kind" integer NOT NULL,
        "Cluster" character varying(256),
        "Namespace" character varying(256) NOT NULL,
        "Workload" character varying(256),
        "Source" character varying(256),
        "Reason" character varying(1024),
        "CreatedAt" timestamp with time zone NOT NULL,
        "CreatedBy" character varying(256),
        CONSTRAINT "PK_ThreatIntelExclusions" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260523000000_ThreatIntelExclusions') THEN
    CREATE INDEX IF NOT EXISTS "IX_ThreatIntelExclusions_Namespace"
        ON "ThreatIntelExclusions" ("Namespace");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260523000000_ThreatIntelExclusions') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260523000000_ThreatIntelExclusions', '10.0.5');
    END IF;
END $EF$;
COMMIT;

-- =============================================================================
-- 20260524000000_IncidentNotificationChannels
-- Operational pack: per-detector beaconing toggle on ThreatIntelSettings,
-- outbound notification channels (Slack / Teams / PagerDuty / OpsGenie /
-- generic webhook) for incident lifecycle events, and per-user saved
-- filter views on the Incidents page.
-- =============================================================================

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260524000000_IncidentNotificationChannels') THEN
    ALTER TABLE "ThreatIntelSettings"
        ADD COLUMN IF NOT EXISTS "BeaconingEnabled" boolean NOT NULL DEFAULT TRUE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260524000000_IncidentNotificationChannels') THEN
    CREATE TABLE IF NOT EXISTS "IncidentNotificationChannels" (
        "Id" uuid NOT NULL,
        "Name" character varying(256) NOT NULL,
        "Kind" character varying(32) NOT NULL,
        "Endpoint" character varying(2048) NOT NULL,
        "Enabled" boolean NOT NULL,
        "MinSeverity" integer NOT NULL,
        "NotifyOnNewIncident" boolean NOT NULL,
        "NotifyOnSeverityEscalation" boolean NOT NULL,
        "NotifyOnResolved" boolean NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "CreatedBy" character varying(256),
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" character varying(256),
        CONSTRAINT "PK_IncidentNotificationChannels" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260524000000_IncidentNotificationChannels') THEN
    CREATE TABLE IF NOT EXISTS "IncidentSavedViews" (
        "Id" uuid NOT NULL,
        "Owner" character varying(256) NOT NULL,
        "Name" character varying(256) NOT NULL,
        "FiltersJson" text,
        "IsDefault" boolean NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_IncidentSavedViews" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260524000000_IncidentNotificationChannels') THEN
    CREATE INDEX IF NOT EXISTS "IX_IncidentSavedViews_Owner"
        ON "IncidentSavedViews" ("Owner");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260524000000_IncidentNotificationChannels') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260524000000_IncidentNotificationChannels', '10.0.5');
    END IF;
END $EF$;
COMMIT;

-- =============================================================================
-- 20260525000000_ManualNetworkPolicies
-- Manual network policies â€” pre-approved src/dst/port rules that network
-- operators agree on with developers and bulk-upload via Excel. Goes
-- through a Pending â†’ Approved/Rejected workflow before surfacing in the
-- Cloud-Side Network Policies view with a "Manual" flag.
-- =============================================================================

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525000000_ManualNetworkPolicies') THEN
    CREATE TABLE IF NOT EXISTS "ManualNetworkPolicies" (
        "Id" uuid NOT NULL,
        "Name" character varying(256) NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Namespace" character varying(256) NOT NULL,
        "Direction" character varying(16) NOT NULL,
        "Source" character varying(512) NOT NULL,
        "Destination" character varying(512) NOT NULL,
        "Protocol" character varying(16) NOT NULL,
        "Port" integer NOT NULL,
        "Description" character varying(1024) NOT NULL DEFAULT '',
        "ApprovalStatus" character varying(32) NOT NULL DEFAULT 'Pending',
        "ApprovedBy" character varying(256),
        "ApprovedAt" timestamp with time zone,
        "RejectedBy" character varying(256),
        "RejectedAt" timestamp with time zone,
        "RejectionReason" character varying(1024),
        "UploadBatchId" uuid NOT NULL,
        "UploadedBy" character varying(256) NOT NULL DEFAULT '',
        "UploadedAt" timestamp with time zone NOT NULL,
        "SourceFileName" character varying(512),
        CONSTRAINT "PK_ManualNetworkPolicies" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525000000_ManualNetworkPolicies') THEN
    CREATE INDEX IF NOT EXISTS "IX_ManualNetworkPolicies_UploadBatchId"
        ON "ManualNetworkPolicies" ("UploadBatchId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525000000_ManualNetworkPolicies') THEN
    CREATE INDEX IF NOT EXISTS "IX_ManualNetworkPolicies_ApprovalStatus"
        ON "ManualNetworkPolicies" ("ApprovalStatus");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525000000_ManualNetworkPolicies') THEN
    CREATE INDEX IF NOT EXISTS "IX_ManualNetworkPolicies_Cluster_Namespace"
        ON "ManualNetworkPolicies" ("ClusterName", "Namespace");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525000000_ManualNetworkPolicies') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260525000000_ManualNetworkPolicies', '10.0.5');
    END IF;
END $EF$;
COMMIT;

-- =============================================================================
-- 20260525010000_ManualNetworkPolicyRbac
-- Grant the built-in roles access to the ManualNetworkPolicy resource.
-- Split from the schema migration above so envs that already applied
-- 20260525000000 before this RBAC existed still pick up the grants.
-- Admin / NetworkOperator â†’ Manage; Auditor â†’ Read; AccessUser â†’ no grant.
-- =============================================================================

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525010000_ManualNetworkPolicyRbac') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    SELECT gen_random_uuid(), g.role_id, g.resource, g.scope
    FROM (VALUES
        ('00000001-0000-0000-0000-000000000001'::uuid, 'ManualNetworkPolicy', 'Manage'),
        ('00000002-0000-0000-0000-000000000002'::uuid, 'ManualNetworkPolicy', 'Manage'),
        ('00000003-0000-0000-0000-000000000003'::uuid, 'ManualNetworkPolicy', 'Read')
    ) AS g(role_id, resource, scope)
    WHERE NOT EXISTS (
        SELECT 1 FROM "CustomRolePermissions" p
        WHERE p."CustomRoleId" = g.role_id
          AND p."Resource"     = g.resource
          AND p."Scope"        = g.scope
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525010000_ManualNetworkPolicyRbac') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260525010000_ManualNetworkPolicyRbac', '10.0.5');
    END IF;
END $EF$;
COMMIT;

-- =============================================================================
-- 20260525103259_ThreatIntelAdded
-- EF Core re-generated this migration after the model snapshot caught up to
-- the current code: relaxes a handful of character varying(N) columns to
-- plain text, drops some indexes that the regenerated snapshot no longer
-- declares, strips a few defaults the entity no longer carries, and recreates
-- PolicyHitDaily under the new shape. PolicyHitDaily is wrapped in
-- CREATE TABLE IF NOT EXISTS because an earlier migration (20260512100000)
-- already created it on existing clusters.
-- =============================================================================

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    -- ---- index cleanups (IF EXISTS so a re-run is harmless) ---------------
    DROP INDEX IF EXISTS "IX_ManualNetworkPolicies_ApprovalStatus";
    DROP INDEX IF EXISTS "IX_ManualNetworkPolicies_ClusterName_Namespace";
    DROP INDEX IF EXISTS "IX_ManualNetworkPolicies_UploadBatchId";
    DROP INDEX IF EXISTS "IX_AuditEntries_At";
    DROP INDEX IF EXISTS "IX_AuditEntries_Category";
    DROP INDEX IF EXISTS "IX_AnalyticsSavedViews_OwnerUserId";
    DROP INDEX IF EXISTS "IX_AnalyticsAuditEntries_At";
    DROP INDEX IF EXISTS "IX_AnalyticsAlertRules_OwnerUserId";

    -- ---- ManualNetworkPolicies: relax char-varying columns to text -------
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "Name"            TYPE text;
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "ClusterName"     TYPE text;
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "Namespace"       TYPE text;
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "Direction"       TYPE text;
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "Source"          TYPE text;
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "Destination"     TYPE text;
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "Protocol"        TYPE text;
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "Description"     TYPE text;
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "ApprovalStatus"  TYPE text;
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "ApprovedBy"      TYPE text;
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "RejectedBy"      TYPE text;
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "RejectionReason" TYPE text;
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "UploadedBy"      TYPE text;
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "SourceFileName"  TYPE text;

    -- ---- default-value strips --------------------------------------------
    ALTER TABLE "SiemSettings"          ALTER COLUMN "RetentionDays"  DROP DEFAULT;
    ALTER TABLE "OpenShiftIntegrations" ALTER COLUMN "IsEnabled"      DROP DEFAULT;
    ALTER TABLE "CustomRoles"           ALTER COLUMN "IsBuiltIn"      DROP DEFAULT;
    ALTER TABLE "AnalyticsAlertRules"   ALTER COLUMN "SuppressMinutes" DROP DEFAULT;
    ALTER TABLE "AnalyticsAlertRules"   ALTER COLUMN "Severity"       DROP DEFAULT;
    ALTER TABLE "AnalyticsAlertRules"   ALTER COLUMN "ClusterId"      DROP DEFAULT;

    -- ---- PolicyHitDaily recreate (no-op when 20260512100000 already ran) -
    CREATE TABLE IF NOT EXISTS "PolicyHitDaily" (
        "PolicyRecordId" uuid NOT NULL,
        "Day"            timestamp with time zone NOT NULL,
        "Count"          bigint NOT NULL,
        "UpdatedAt"      timestamp with time zone NOT NULL,
        CONSTRAINT "PK_PolicyHitDaily" PRIMARY KEY ("PolicyRecordId", "Day")
    );
    CREATE INDEX IF NOT EXISTS "IX_PolicyHitDaily_Day" ON "PolicyHitDaily" ("Day");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260525103259_ThreatIntelAdded', '10.0.5');
    END IF;
END $EF$;

-- 20260601140000_AiSettingsAdded
-- DB-backed singleton row for the AI assistant configuration (model / endpoint
-- + behavioral-anomaly advisory tuning). No seed row here â€” the API seeds the
-- singleton from the "Ai" appsettings section on first boot.

-- ---- AiSettings (singleton) ------------------------------------------------

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260601140000_AiSettingsAdded') THEN
    CREATE TABLE IF NOT EXISTS "AiSettings" (
        "Id" uuid NOT NULL,
        "Enabled" boolean NOT NULL,
        "Provider" character varying(64) NOT NULL,
        "BaseUrl" character varying(512) NOT NULL,
        "Model" character varying(256) NOT NULL,
        "ApiKey" character varying(512),
        "TimeoutSeconds" integer NOT NULL,
        "Temperature" double precision NOT NULL,
        "AdvisoryEnabled" boolean NOT NULL,
        "AdvisoryLookbackHours" integer NOT NULL,
        "AdvisoryMaxWorkloads" integer NOT NULL,
        "AdvisoryMaxDestinationsPerWorkload" integer NOT NULL,
        "AdvisoryMinConfidence" integer NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" character varying(256),
        CONSTRAINT "PK_AiSettings" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260601140000_AiSettingsAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260601140000_AiSettingsAdded', '10.0.5');
    END IF;
END $EF$;
COMMIT;

-- 20260603120000_AiPolicyAdvisoryAdded
-- Background policy-recommendation tuning on the AiSettings singleton: master
-- toggle + per-cluster re-analysis interval (the effective cadence) + per-cluster
-- policy cap. Existing rows default to off / daily / 60 via the column defaults,
-- so the upgrade is a no-op until an admin enables it on the AI Platform page.

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260603120000_AiPolicyAdvisoryAdded') THEN
    ALTER TABLE "AiSettings" ADD COLUMN "PolicyAdvisoryEnabled" boolean NOT NULL DEFAULT FALSE;
    ALTER TABLE "AiSettings" ADD COLUMN "PolicyAdvisoryIntervalHours" integer NOT NULL DEFAULT 24;
    ALTER TABLE "AiSettings" ADD COLUMN "PolicyAdvisoryMaxPolicies" integer NOT NULL DEFAULT 60;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260603120000_AiPolicyAdvisoryAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260603120000_AiPolicyAdvisoryAdded', '10.0.5');
    END IF;
END $EF$;
COMMIT;

-- 20260604130000_NetworkPolicyDeploymentState
-- Distinguishes a NetworkPolicyRecord saved in Axera ("Draft") from one that
-- physically exists in the target cluster ("Deployed"). Existing rows default to
-- 'Draft'; the deployment reconciler promotes the ones actually present in the
-- cluster to 'Deployed' on the next pass, so the upgrade is safe.
START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260604130000_NetworkPolicyDeploymentState') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD COLUMN "DeploymentState" character varying(32) NOT NULL DEFAULT 'Draft';
    ALTER TABLE "NetworkPolicyRecords" ADD COLUMN "LastDeployedAt" timestamp with time zone NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260604130000_NetworkPolicyDeploymentState') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260604130000_NetworkPolicyDeploymentState', '10.0.7');
    END IF;
END $EF$;
COMMIT;

-- 20260603130000_IncidentMitreAndScore
-- Adds MITRE ATT&CK technique tag + 0-100 entity score to Incidents so
-- pre-computed NDR detections (Radar fan-out / egress-volume) surface their
-- technique and Threat x Certainty priority in the UI. Both nullable, so
-- existing detectors are untouched and the upgrade is safe.
START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260603130000_IncidentMitreAndScore') THEN
    ALTER TABLE "Incidents" ADD COLUMN "MitreTechnique" character varying(32) NULL;
    ALTER TABLE "Incidents" ADD COLUMN "Score" integer NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260603130000_IncidentMitreAndScore') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260603130000_IncidentMitreAndScore', '10.0.7');
    END IF;
END $EF$;
COMMIT;
-- 20260608120000_ShiftLeftAdded
-- Shift-Left: source-derived NetworkPolicy recommendations (repos opted into
-- scanning, scan runs, derived intents, synthesised recommendations).
START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260608120000_ShiftLeftAdded') THEN
    CREATE TABLE "ScanRepositories" (
        "Id" uuid NOT NULL,
        "Provider" character varying(32) NOT NULL,
        "RepositoryUrl" character varying(1024) NOT NULL,
        "Owner" character varying(256) NULL,
        "Name" character varying(256) NULL,
        "Branch" character varying(256) NOT NULL,
        "PathGlobs" text NULL,
        "TargetClusterName" character varying(256) NULL,
        "TargetNamespace" character varying(256) NULL,
        "AnalyzeManifests" boolean NOT NULL,
        "AnalyzeDockerfile" boolean NOT NULL,
        "AnalyzeCodeWithAi" boolean NOT NULL,
        "Enabled" boolean NOT NULL,
        "ScheduledScanEnabled" boolean NOT NULL,
        "ScanIntervalHours" integer NOT NULL,
        "LastScanAt" timestamp with time zone NULL,
        "LastScanStatus" character varying(32) NULL,
        "LastCommitSha" character varying(64) NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "CreatedBy" character varying(256) NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" character varying(256) NULL,
        CONSTRAINT "PK_ScanRepositories" PRIMARY KEY ("Id")
    );
    CREATE TABLE "RepositoryScans" (
        "Id" uuid NOT NULL,
        "ScanRepositoryId" uuid NOT NULL,
        "Status" character varying(32) NOT NULL,
        "Trigger" character varying(16) NOT NULL,
        "CommitSha" character varying(64) NULL,
        "StartedAt" timestamp with time zone NOT NULL,
        "CompletedAt" timestamp with time zone NULL,
        "IntentCount" integer NOT NULL,
        "RecommendationCount" integer NOT NULL,
        "Error" text NULL,
        "TriggeredBy" character varying(256) NULL,
        CONSTRAINT "PK_RepositoryScans" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_RepositoryScans_ScanRepositories_ScanRepositoryId" FOREIGN KEY ("ScanRepositoryId") REFERENCES "ScanRepositories" ("Id") ON DELETE CASCADE
    );
    CREATE TABLE "PolicyIntents" (
        "Id" uuid NOT NULL,
        "RepositoryScanId" uuid NOT NULL,
        "SrcWorkload" character varying(256) NOT NULL,
        "SrcNamespace" character varying(256) NOT NULL,
        "DstWorkload" character varying(256) NULL,
        "DstNamespace" character varying(256) NULL,
        "DstExternal" boolean NOT NULL,
        "DstHost" character varying(512) NULL,
        "Port" integer NOT NULL,
        "Protocol" character varying(16) NOT NULL,
        "Direction" character varying(16) NOT NULL,
        "Confidence" integer NOT NULL,
        "Analyzer" character varying(16) NOT NULL,
        "EvidenceFile" character varying(1024) NULL,
        "EvidenceLine" integer NULL,
        "EvidenceCommit" character varying(64) NULL,
        "EvidenceSnippet" character varying(2000) NULL,
        CONSTRAINT "PK_PolicyIntents" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_PolicyIntents_RepositoryScans_RepositoryScanId" FOREIGN KEY ("RepositoryScanId") REFERENCES "RepositoryScans" ("Id") ON DELETE CASCADE
    );
    CREATE TABLE "PolicyRecommendations" (
        "Id" uuid NOT NULL,
        "ScanRepositoryId" uuid NOT NULL,
        "RepositoryScanId" uuid NOT NULL,
        "ClusterName" character varying(256) NULL,
        "TargetNamespace" character varying(256) NULL,
        "TargetWorkload" character varying(256) NULL,
        "PolicyName" character varying(256) NOT NULL,
        "PolicyYaml" text NULL,
        "Confidence" integer NOT NULL,
        "Summary" text NULL,
        "Status" character varying(16) NOT NULL,
        "NetworkPolicyRecordId" uuid NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "DecidedAt" timestamp with time zone NULL,
        "DecidedBy" character varying(256) NULL,
        CONSTRAINT "PK_PolicyRecommendations" PRIMARY KEY ("Id")
    );
    CREATE UNIQUE INDEX "IX_ScanRepositories_Url_Branch" ON "ScanRepositories" ("RepositoryUrl", "Branch");
    CREATE INDEX "IX_RepositoryScans_ScanRepositoryId" ON "RepositoryScans" ("ScanRepositoryId");
    CREATE INDEX "IX_PolicyIntents_RepositoryScanId" ON "PolicyIntents" ("RepositoryScanId");
    CREATE INDEX "IX_PolicyRecommendations_ScanRepositoryId" ON "PolicyRecommendations" ("ScanRepositoryId");
    CREATE INDEX "IX_PolicyRecommendations_RepositoryScanId" ON "PolicyRecommendations" ("RepositoryScanId");
    CREATE INDEX "IX_PolicyRecommendations_Status" ON "PolicyRecommendations" ("Status");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260608120000_ShiftLeftAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260608120000_ShiftLeftAdded', '10.0.7');
    END IF;
END $EF$;
COMMIT;

-- 20260609120000_AiMultiProviderAdded
-- Multi-provider AI: N named provider configs (Ollama / Anthropic / OpenAI /
-- Azure OpenAI / OpenAI-compatible) + per-feature routing to a config.
START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260609120000_AiMultiProviderAdded') THEN
    CREATE TABLE "AiModelConfigs" (
        "Id" uuid NOT NULL,
        "Name" character varying(128) NOT NULL,
        "Provider" character varying(64) NOT NULL,
        "BaseUrl" character varying(512) NOT NULL,
        "Model" character varying(256) NOT NULL,
        "ApiKey" character varying(1024) NULL,
        "ApiVersion" character varying(64) NULL,
        "TimeoutSeconds" integer NOT NULL,
        "Temperature" double precision NOT NULL,
        "MaxTokens" integer NOT NULL,
        "Enabled" boolean NOT NULL,
        "IsDefault" boolean NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" character varying(256) NULL,
        CONSTRAINT "PK_AiModelConfigs" PRIMARY KEY ("Id")
    );
    CREATE TABLE "AiFeatureRoutes" (
        "Id" uuid NOT NULL,
        "Feature" character varying(64) NOT NULL,
        "AiModelConfigId" uuid NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" character varying(256) NULL,
        CONSTRAINT "PK_AiFeatureRoutes" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_AiFeatureRoutes_AiModelConfigs_AiModelConfigId" FOREIGN KEY ("AiModelConfigId") REFERENCES "AiModelConfigs" ("Id") ON DELETE CASCADE
    );
    CREATE UNIQUE INDEX "IX_AiModelConfigs_Name" ON "AiModelConfigs" ("Name");
    CREATE UNIQUE INDEX "IX_AiFeatureRoutes_Feature" ON "AiFeatureRoutes" ("Feature");
    CREATE INDEX "IX_AiFeatureRoutes_AiModelConfigId" ON "AiFeatureRoutes" ("AiModelConfigId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260609120000_AiMultiProviderAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260609120000_AiMultiProviderAdded', '10.0.7');
    END IF;
END $EF$;
COMMIT;

-- ProtectedNamespaceSettings: operator delta for the configurable protected-namespace guard (jsonb)
START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260701170428_ProtectedNamespaceSettingsAdded') THEN
    CREATE TABLE "ProtectedNamespaceSettings" (
        "Id" uuid NOT NULL,
        "Config" jsonb NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" text,
        CONSTRAINT "PK_ProtectedNamespaceSettings" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260701170428_ProtectedNamespaceSettingsAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260701170428_ProtectedNamespaceSettingsAdded', '10.0.7');
    END IF;
END $EF$;
COMMIT;

-- DataProtectionKeys: DB-backed ASP.NET DataProtection key-ring (app.dpKeysStore=Database) â€” 20260703120841_DataProtectionKeysAdded
START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260703120841_DataProtectionKeysAdded') THEN
    CREATE TABLE "DataProtectionKeys" (
        "Id" integer GENERATED BY DEFAULT AS IDENTITY,
        "FriendlyName" text,
        "Xml" text,
        CONSTRAINT "PK_DataProtectionKeys" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260703120841_DataProtectionKeysAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260703120841_DataProtectionKeysAdded', '10.0.7');
    END IF;
END $EF$;
COMMIT;


-- v9.0.0: SiemPolicyHit ForwardedAt + incident partial-unique (idempotent)
START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260710131804_SiemPolicyHitForwardedAndIncidentDedup') THEN
    DROP INDEX "IX_Incidents_CorrelationKey_Active";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260710131804_SiemPolicyHitForwardedAndIncidentDedup') THEN
    ALTER TABLE "PolicyHitDaily" ADD "ForwardedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260710131804_SiemPolicyHitForwardedAndIncidentDedup') THEN
    CREATE INDEX "IX_PolicyHitDaily_ForwardedAt_UpdatedAt" ON "PolicyHitDaily" ("UpdatedAt") WHERE "ForwardedAt" IS NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260710131804_SiemPolicyHitForwardedAndIncidentDedup') THEN

                    UPDATE "Incidents" i
                    SET "Status" = 2
                    WHERE i."Status" IN (0, 1)
                      AND EXISTS (
                          SELECT 1 FROM "Incidents" j
                          WHERE j."CorrelationKey" = i."CorrelationKey"
                            AND j."Status" IN (0, 1)
                            AND (j."LastSeenAt" > i."LastSeenAt"
                                 OR (j."LastSeenAt" = i."LastSeenAt" AND j."Id" > i."Id"))
                      );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260710131804_SiemPolicyHitForwardedAndIncidentDedup') THEN
    CREATE UNIQUE INDEX "IX_Incidents_CorrelationKey_Active" ON "Incidents" ("CorrelationKey") WHERE "Status" IN (0, 1);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260710131804_SiemPolicyHitForwardedAndIncidentDedup') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260710131804_SiemPolicyHitForwardedAndIncidentDedup', '10.0.7');
    END IF;
END $EF$;
COMMIT;



-- v0.7.3: Backup/Restore (BackupRecords + BackupSettings) â€” idempotent
START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260716085021_BackupAndRestore') THEN
    CREATE TABLE "BackupRecords" (
        "Id" uuid NOT NULL,
        "Name" character varying(256),
        "Database" character varying(16) NOT NULL,
        "Source" character varying(16) NOT NULL,
        "Kind" character varying(32) NOT NULL,
        "StorageProvider" character varying(16) NOT NULL,
        "Location" character varying(1024),
        "SizeBytes" bigint NOT NULL,
        "ProductVersion" character varying(64),
        "Status" character varying(16) NOT NULL,
        "Error" text,
        "JobName" character varying(256),
        "CreatedAt" timestamp with time zone NOT NULL,
        "CompletedAt" timestamp with time zone,
        "TriggeredBy" character varying(256),
        CONSTRAINT "PK_BackupRecords" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260716085021_BackupAndRestore') THEN
    CREATE TABLE "BackupSettings" (
        "Id" uuid NOT NULL,
        "DailyEnabled" boolean NOT NULL,
        "DailyCron" character varying(64) NOT NULL,
        "WeeklyEnabled" boolean NOT NULL,
        "WeeklyCron" character varying(64) NOT NULL,
        "MonthlyEnabled" boolean NOT NULL,
        "MonthlyCron" character varying(64) NOT NULL,
        "RetentionDaily" integer NOT NULL,
        "RetentionWeekly" integer NOT NULL,
        "RetentionMonthly" integer NOT NULL,
        "DefaultProvider" character varying(16) NOT NULL,
        "PvcClaimName" character varying(256),
        "PvcSubPath" character varying(512),
        "NfsServer" character varying(256),
        "NfsPath" character varying(512),
        "S3Endpoint" character varying(512),
        "S3Region" character varying(64),
        "S3Bucket" character varying(256),
        "S3AccessKey" character varying(256),
        "S3SecretKeyProtected" text,
        "S3ForcePathStyle" boolean NOT NULL,
        CONSTRAINT "PK_BackupSettings" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260716085021_BackupAndRestore') THEN
    CREATE INDEX "IX_BackupRecords_CreatedAt" ON "BackupRecords" ("CreatedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260716085021_BackupAndRestore') THEN
    CREATE INDEX "IX_BackupRecords_Database_Source" ON "BackupRecords" ("Database", "Source");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260716085021_BackupAndRestore') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260716085021_BackupAndRestore', '10.0.7');
    END IF;
END $EF$;
COMMIT;

-- v0.7.3: Backup schema self-heal (drift guard). The CREATE TABLE blocks above are
-- migration-history-guarded, so if BackupRecords/BackupSettings were created by an EARLIER
-- revision (before the Name/ProductVersion/Monthly columns existed) the CREATE is skipped and
-- those columns would be missing. ADD COLUMN IF NOT EXISTS backfills them regardless; it's a
-- no-op once present, and the to_regclass guards skip cleanly when backup is disabled.
DO $$
BEGIN
  IF to_regclass('"BackupRecords"') IS NOT NULL THEN
    ALTER TABLE "BackupRecords"  ADD COLUMN IF NOT EXISTS "Name" character varying(256);
    ALTER TABLE "BackupRecords"  ADD COLUMN IF NOT EXISTS "ProductVersion" character varying(64);
  END IF;
  IF to_regclass('"BackupSettings"') IS NOT NULL THEN
    ALTER TABLE "BackupSettings" ADD COLUMN IF NOT EXISTS "MonthlyEnabled" boolean NOT NULL DEFAULT false;
    ALTER TABLE "BackupSettings" ADD COLUMN IF NOT EXISTS "MonthlyCron" character varying(64) NOT NULL DEFAULT '0 4 1 * *';
    ALTER TABLE "BackupSettings" ADD COLUMN IF NOT EXISTS "RetentionMonthly" integer NOT NULL DEFAULT 6;
  END IF;
END $$;


START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260720140022_SiemDestinations') THEN

    CREATE TABLE IF NOT EXISTS "SiemDestinations" (
        "Id" uuid NOT NULL,
        "Name" character varying(256) NOT NULL,
        "Enabled" boolean NOT NULL,
        "Protocol" integer NOT NULL,
        "EndpointUrl" character varying(2048),
        "Token" text,
        "Index" character varying(256),
        "SyslogHost" character varying(512),
        "SyslogPort" integer,
        "AppName" character varying(256),
        "AllowInsecureTls" boolean NOT NULL,
        "CaCert" text,
        "IsDefault" boolean NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" character varying(256),
        CONSTRAINT "PK_SiemDestinations" PRIMARY KEY ("Id")
    );
    -- Self-heal for a DB that already created SiemDestinations before CaCert existed.
    ALTER TABLE "SiemDestinations" ADD COLUMN IF NOT EXISTS "CaCert" text;
    CREATE UNIQUE INDEX IF NOT EXISTS "IX_SiemDestinations_Name" ON "SiemDestinations" ("Name");
    CREATE UNIQUE INDEX IF NOT EXISTS "IX_SiemDestinations_IsDefault" ON "SiemDestinations" ("IsDefault") WHERE "IsDefault" = true;

    ALTER TABLE "SiemSettings" ADD COLUMN IF NOT EXISTS "AuditDestinationId" uuid;
    ALTER TABLE "SiemSettings" ADD COLUMN IF NOT EXISTS "PolicyMonitoringDestinationId" uuid;
    ALTER TABLE "SiemSettings" ADD COLUMN IF NOT EXISTS "IncidentsDestinationId" uuid;

    -- Back-compat: migrate the legacy single destination into a "Default" destination
    -- and point every stream at it. Guarded on data so it's a no-op once applied.
    INSERT INTO "SiemDestinations"
        ("Id","Name","Enabled","Protocol","EndpointUrl","Token","Index",
         "SyslogHost","SyslogPort","AppName","AllowInsecureTls","IsDefault","CreatedAt","UpdatedAt","UpdatedBy")
    SELECT gen_random_uuid(), 'Default', true, s."Protocol", s."EndpointUrl", s."Token", s."Index",
           s."SyslogHost", s."SyslogPort", COALESCE(s."AppName",'axera'), s."AllowInsecureTls", true, now(), now(), s."UpdatedBy"
    FROM "SiemSettings" s
    WHERE NOT EXISTS (SELECT 1 FROM "SiemDestinations" d WHERE d."IsDefault" OR d."Name" = 'Default');

    UPDATE "SiemSettings" s
    SET "AuditDestinationId"            = COALESCE(s."AuditDestinationId", d."Id"),
        "PolicyMonitoringDestinationId" = COALESCE(s."PolicyMonitoringDestinationId", d."Id"),
        "IncidentsDestinationId"        = COALESCE(s."IncidentsDestinationId", d."Id")
    FROM "SiemDestinations" d WHERE d."IsDefault";

    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260720140022_SiemDestinations') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260720140022_SiemDestinations', '10.0.7');
    END IF;
END $EF$;
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721084748_AddLicenseEdition') THEN
    ALTER TABLE "LicenseInfos" ADD COLUMN IF NOT EXISTS "Edition" integer NOT NULL DEFAULT 2;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721084748_AddLicenseEdition') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260721084748_AddLicenseEdition', '10.0.7');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721121642_AddIncidentProcessAttribution') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "DstNamespace" text;
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "DstWorkload" text;
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "ProcessBinary" text;
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "ProcessArgs" text;
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "ProcessPid" integer;
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "ProcessUid" bigint;
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "PodName" text;
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "ContainerName" text;
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "NodeName" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721121642_AddIncidentProcessAttribution') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260721121642_AddIncidentProcessAttribution', '10.0.7');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721122551_AddDeniedSprayDetectorSetting') THEN
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "DeniedSprayEnabled" boolean NOT NULL DEFAULT true;
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "CloudMetadataAbuseEnabled" boolean NOT NULL DEFAULT true;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721122551_AddDeniedSprayDetectorSetting') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260721122551_AddDeniedSprayDetectorSetting', '10.0.7');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721123923_AddMeshDenyDetectorSetting') THEN
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "MeshDenyEnabled" boolean NOT NULL DEFAULT true;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721123923_AddMeshDenyDetectorSetting') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260721123923_AddMeshDenyDetectorSetting', '10.0.7');
    END IF;
END $EF$;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721195257_AddWorkloadCriticality') THEN
    CREATE TABLE IF NOT EXISTS "WorkloadCriticalities" (
        "Id" uuid NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Namespace" character varying(256) NOT NULL,
        "Workload" character varying(256) NOT NULL,
        "Tier" integer NOT NULL,
        "Note" character varying(1024),
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" character varying(256),
        CONSTRAINT "PK_WorkloadCriticalities" PRIMARY KEY ("Id")
    );
    CREATE UNIQUE INDEX IF NOT EXISTS "IX_WorkloadCriticalities_Identity" ON "WorkloadCriticalities" ("ClusterName", "Namespace", "Workload");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721195257_AddWorkloadCriticality') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260721195257_AddWorkloadCriticality', '10.0.7');
    END IF;
END $EF$;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721203248_AddRadarStateSnapshot') THEN
    CREATE TABLE IF NOT EXISTS "RadarStateSnapshots" (
        "Key" character varying(128) NOT NULL,
        "Json" text NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_RadarStateSnapshots" PRIMARY KEY ("Key")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721203248_AddRadarStateSnapshot') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260721203248_AddRadarStateSnapshot', '10.0.7');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721215347_AddIncidentL4Protocol') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "Proto" integer NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721215347_AddIncidentL4Protocol') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260721215347_AddIncidentL4Protocol', '10.0.7');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721220655_AddDetectionTuningSettings') THEN
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "Sensitivity" integer NOT NULL DEFAULT 1;
    END IF;
END $EF$;
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721220655_AddDetectionTuningSettings') THEN
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "SensitiveNamespaces" text NULL;
    END IF;
END $EF$;
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721220655_AddDetectionTuningSettings') THEN
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "IpReputationEastWest" boolean NOT NULL DEFAULT false;
    END IF;
END $EF$;
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721220655_AddDetectionTuningSettings') THEN
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "FeedRefreshIntervalHours" integer NOT NULL DEFAULT 24;
    END IF;
END $EF$;
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721220655_AddDetectionTuningSettings') THEN
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "ProviderDailyBudget" integer NOT NULL DEFAULT 1000;
    END IF;
END $EF$;
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721220655_AddDetectionTuningSettings') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260721220655_AddDetectionTuningSettings', '10.0.7');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260722111249_AddPolicySoftDeleteRetention') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD COLUMN IF NOT EXISTS "DeletedAt" timestamp with time zone NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260722111249_AddPolicySoftDeleteRetention') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD COLUMN IF NOT EXISTS "RecoveredAt" timestamp with time zone NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260722111249_AddPolicySoftDeleteRetention') THEN
    ALTER TABLE "AnalyticsSettings" ADD COLUMN IF NOT EXISTS "DeletedPolicyRetentionDays" integer NOT NULL DEFAULT 5;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260722111249_AddPolicySoftDeleteRetention') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260722111249_AddPolicySoftDeleteRetention', '10.0.7');
    END IF;
END $EF$;



-- 20260803135130_AddIncidentContainment (synced)
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "ContainedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "ContainedBy" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "ContainmentExpiresAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "ContainmentLiftedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "ContainmentLiftedReason" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "ContainmentPolicyName" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "ContainmentPolicyRecordId" uuid;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    ALTER TABLE "AnalyticsSettings" ADD COLUMN IF NOT EXISTS "ContainmentDefaultTtlHours" integer NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260803135130_AddIncidentContainment', '10.0.7');
    END IF;
END $EF$;

-- 20260805070111_AddContainmentActionsAndSrcPrincipal (synced)
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805070111_AddContainmentActionsAndSrcPrincipal') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "SrcPrincipal" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805070111_AddContainmentActionsAndSrcPrincipal') THEN
    CREATE TABLE IF NOT EXISTS "ContainmentActions" (
        "Id" uuid NOT NULL,
        "IncidentId" uuid NOT NULL,
        "Plane" character varying(32) NOT NULL,
        "ClusterName" character varying(256),
        "ObjectNamespace" character varying(256),
        "PolicyName" character varying(256) NOT NULL,
        "AppliedAt" timestamp with time zone NOT NULL,
        "AppliedBy" character varying(256),
        "LiftedAt" timestamp with time zone,
        "LiftedReason" text,
        "LastError" text,
        "Status" character varying(16) NOT NULL,
        CONSTRAINT "PK_ContainmentActions" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_ContainmentActions_Incidents_IncidentId" FOREIGN KEY ("IncidentId") REFERENCES "Incidents" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805070111_AddContainmentActionsAndSrcPrincipal') THEN
    CREATE INDEX IF NOT EXISTS "IX_ContainmentActions_Incident_Status" ON "ContainmentActions" ("IncidentId", "Status");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805070111_AddContainmentActionsAndSrcPrincipal') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260805070111_AddContainmentActionsAndSrcPrincipal', '10.0.7');
    END IF;
END $EF$;

-- 20260805072730_AddResponsePlaybooks (synced)
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805072730_AddResponsePlaybooks') THEN
    CREATE TABLE IF NOT EXISTS "IncidentResponsePlaybooks" (
        "Id" uuid NOT NULL,
        "Name" character varying(256) NOT NULL,
        "Enabled" boolean NOT NULL,
        "Priority" integer NOT NULL,
        "Detectors" text,
        "MinSeverity" character varying(16) NOT NULL,
        "MinCriticalityTier" character varying(16) NOT NULL,
        "ClusterFilter" character varying(256),
        "NamespaceFilter" character varying(256),
        "Action" character varying(32) NOT NULL,
        "Planes" character varying(256),
        "TtlHoursOverride" integer,
        "StopOnMatch" boolean NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "CreatedBy" character varying(256),
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" character varying(256),
        CONSTRAINT "PK_IncidentResponsePlaybooks" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805072730_AddResponsePlaybooks') THEN
    CREATE TABLE IF NOT EXISTS "PlaybookExecutions" (
        "Id" uuid NOT NULL,
        "PlaybookId" uuid NOT NULL,
        "PlaybookName" character varying(256) NOT NULL,
        "IncidentId" uuid NOT NULL,
        "MatchedAt" timestamp with time zone NOT NULL,
        "ActionTaken" character varying(32) NOT NULL,
        "Outcome" character varying(32) NOT NULL,
        "Detail" text,
        CONSTRAINT "PK_PlaybookExecutions" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805072730_AddResponsePlaybooks') THEN
    CREATE INDEX IF NOT EXISTS "IX_IncidentResponsePlaybooks_Enabled_Priority" ON "IncidentResponsePlaybooks" ("Enabled", "Priority");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805072730_AddResponsePlaybooks') THEN
    CREATE INDEX IF NOT EXISTS "IX_PlaybookExecutions_IncidentId" ON "PlaybookExecutions" ("IncidentId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805072730_AddResponsePlaybooks') THEN
    CREATE INDEX IF NOT EXISTS "IX_PlaybookExecutions_MatchedAt" ON "PlaybookExecutions" ("MatchedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805072730_AddResponsePlaybooks') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260805072730_AddResponsePlaybooks', '10.0.7');
    END IF;
END $EF$;

-- 20260805073750_AddAutoResponseSettings (synced)
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805073750_AddAutoResponseSettings') THEN
    ALTER TABLE "AnalyticsSettings" ADD COLUMN IF NOT EXISTS "AutoResponseEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805073750_AddAutoResponseSettings') THEN
    ALTER TABLE "AnalyticsSettings" ADD COLUMN IF NOT EXISTS "AutoResponseMode" text NOT NULL DEFAULT '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805073750_AddAutoResponseSettings') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260805073750_AddAutoResponseSettings', '10.0.7');
    END IF;
END $EF$;

-- 20260805074650_AddThreatIntelEgressBlock (synced)
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805074650_AddThreatIntelEgressBlock') THEN
    ALTER TABLE "AnalyticsSettings" ADD COLUMN IF NOT EXISTS "ThreatIntelEgressBlockEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805074650_AddThreatIntelEgressBlock') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260805074650_AddThreatIntelEgressBlock', '10.0.7');
    END IF;
END $EF$;


-- 20260805123625_AddContainmentVerification (NDR Response P2 FR-35 containment verification)
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805123625_AddContainmentVerification') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "FlowLastSeenAfterContainAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805123625_AddContainmentVerification') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "LastVerifiedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805123625_AddContainmentVerification') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "VerificationStatus" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805123625_AddContainmentVerification') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "VerifiedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805123625_AddContainmentVerification') THEN
    ALTER TABLE "AnalyticsSettings" ADD COLUMN IF NOT EXISTS "ContainmentAutoReopenOnResume" boolean NOT NULL DEFAULT TRUE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805123625_AddContainmentVerification') THEN
    ALTER TABLE "AnalyticsSettings" ADD COLUMN IF NOT EXISTS "ContainmentVerifyGraceMinutes" integer NOT NULL DEFAULT 15;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805123625_AddContainmentVerification') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260805123625_AddContainmentVerification', '10.0.7');
    END IF;
END $EF$;

-- 20260807142835_AddIncidentReplicaFusion (synced)
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807142835_AddIncidentReplicaFusion') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "ReplicaCount" integer NOT NULL DEFAULT 1;
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "ReplicaKeys" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807142835_AddIncidentReplicaFusion') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260807142835_AddIncidentReplicaFusion', '10.0.7');
    END IF;
END $EF$;

-- 20260807143956_AddTlsFingerprintSecretReadSettings (synced)
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807143956_AddTlsFingerprintSecretReadSettings') THEN
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "TlsFingerprintEnabled" boolean NOT NULL DEFAULT true;
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "SecretReadEnabled" boolean NOT NULL DEFAULT true;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807143956_AddTlsFingerprintSecretReadSettings') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260807143956_AddTlsFingerprintSecretReadSettings', '10.0.7');
    END IF;
END $EF$;

-- 20260807145318_AddKubeAuditSetting (synced)
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807145318_AddKubeAuditSetting') THEN
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "KubeAuditEnabled" boolean NOT NULL DEFAULT true;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807145318_AddKubeAuditSetting') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260807145318_AddKubeAuditSetting', '10.0.7');
    END IF;
END $EF$;

-- 20260807145834_AddWorkloadImagePosture (synced)
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807145834_AddWorkloadImagePosture') THEN
    CREATE TABLE IF NOT EXISTS "WorkloadImagePostures" (
        "Id" uuid NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Namespace" character varying(256) NOT NULL,
        "Workload" character varying(256) NOT NULL,
        "Image" character varying(1024) NOT NULL,
        "ImageDigest" character varying(256) NULL,
        "CriticalCves" integer NOT NULL DEFAULT 0,
        "HighCves" integer NOT NULL DEFAULT 0,
        "MediumCves" integer NOT NULL DEFAULT 0,
        "LowCves" integer NOT NULL DEFAULT 0,
        "FixableCves" integer NOT NULL DEFAULT 0,
        "TopCveIds" character varying(2048) NULL,
        "Scanner" character varying(64) NULL,
        "ScannedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_WorkloadImagePostures" PRIMARY KEY ("Id")
    );
    CREATE UNIQUE INDEX IF NOT EXISTS "IX_WorkloadImagePostures_Identity"
        ON "WorkloadImagePostures" ("ClusterName", "Namespace", "Workload", "Image");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807145834_AddWorkloadImagePosture') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260807145834_AddWorkloadImagePosture', '10.0.7');
    END IF;
END $EF$;

COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260813093542_AddCaptureSessions') THEN
    CREATE TABLE "CaptureArtifacts" (
        "Id" uuid NOT NULL,
        "CaptureSessionId" uuid NOT NULL,
        "Data" bytea NOT NULL,
        "SizeBytes" bigint NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_CaptureArtifacts" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260813093542_AddCaptureSessions') THEN
    CREATE TABLE "CaptureSessions" (
        "Id" uuid NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "SrcOwner" character varying(256) NOT NULL,
        "SrcNamespace" character varying(256) NOT NULL,
        "SrcPod" character varying(256),
        "SrcIp" character varying(64),
        "DstOwner" character varying(256),
        "DstNamespace" character varying(256),
        "DstPod" character varying(256),
        "DstIp" character varying(64),
        "DstPort" integer,
        "Proto" integer NOT NULL,
        "IsExternal" boolean NOT NULL,
        "BpfFilter" character varying(1024) NOT NULL,
        "Snaplen" integer NOT NULL,
        "IncludePayload" boolean NOT NULL,
        "MaxDurationSeconds" integer NOT NULL,
        "MaxSizeBytes" bigint NOT NULL,
        "Status" character varying(16) NOT NULL,
        "Error" text,
        "NodeName" character varying(256),
        "AgentPod" character varying(256),
        "ByteCount" bigint NOT NULL,
        "PacketCount" bigint NOT NULL,
        "StorageProvider" character varying(16) NOT NULL,
        "ArtifactId" uuid,
        "Location" character varying(1024),
        "RetentionDays" integer NOT NULL,
        "RequestedBy" character varying(256),
        "CreatedAt" timestamp with time zone NOT NULL,
        "StartedAt" timestamp with time zone,
        "CompletedAt" timestamp with time zone,
        "ExpiresAt" timestamp with time zone,
        CONSTRAINT "PK_CaptureSessions" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260813093542_AddCaptureSessions') THEN
    CREATE UNIQUE INDEX "IX_CaptureArtifacts_CaptureSessionId" ON "CaptureArtifacts" ("CaptureSessionId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260813093542_AddCaptureSessions') THEN
    CREATE INDEX "IX_CaptureSessions_ClusterName_Status" ON "CaptureSessions" ("ClusterName", "Status");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260813093542_AddCaptureSessions') THEN
    CREATE INDEX "IX_CaptureSessions_CreatedAt" ON "CaptureSessions" ("CreatedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260813093542_AddCaptureSessions') THEN
    CREATE INDEX "IX_CaptureSessions_ExpiresAt" ON "CaptureSessions" ("ExpiresAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260813093542_AddCaptureSessions') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260813093542_AddCaptureSessions', '10.0.7');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260813100436_AddCaptureLabelSelectors') THEN
    ALTER TABLE "CaptureSessions" ADD "DstLabelSelector" character varying(1024);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260813100436_AddCaptureLabelSelectors') THEN
    ALTER TABLE "CaptureSessions" ADD "SrcLabelSelector" character varying(1024);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260813100436_AddCaptureLabelSelectors') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260813100436_AddCaptureLabelSelectors', '10.0.7');
    END IF;
END $EF$;
COMMIT;
START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260813110209_AddCaptureActivePerClusterUniqueIndex') THEN
    CREATE UNIQUE INDEX "UX_CaptureSessions_ActivePerCluster" ON "CaptureSessions" ("ClusterName") WHERE "Status" IN ('Pending','Running');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260813110209_AddCaptureActivePerClusterUniqueIndex') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260813110209_AddCaptureActivePerClusterUniqueIndex', '10.0.7');
    END IF;
END $EF$;
COMMIT;
START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260813111830_AddCaptureIncidentLink') THEN
    ALTER TABLE "CaptureSessions" ADD "IncidentId" uuid;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260813111830_AddCaptureIncidentLink') THEN
    CREATE INDEX "IX_CaptureSessions_IncidentId" ON "CaptureSessions" ("IncidentId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260813111830_AddCaptureIncidentLink') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260813111830_AddCaptureIncidentLink', '10.0.7');
    END IF;
END $EF$;
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE TABLE "AccessRequests" (
        "Id" uuid NOT NULL,
        "Reference" character varying(64) NOT NULL,
        "Type" character varying(32) NOT NULL,
        "Status" character varying(32) NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Namespace" character varying(256),
        "ScopeType" character varying(16) NOT NULL,
        "TargetIdentityId" uuid,
        "TargetIdentityKey" character varying(1024),
        "PayloadJson" text NOT NULL,
        "RiskLevel" character varying(16) NOT NULL,
        "RiskReasonsJson" text,
        "RequestedBy" character varying(256) NOT NULL,
        "Justification" text,
        "CreatedAt" timestamp with time zone NOT NULL,
        "SubmittedAt" timestamp with time zone,
        "DecidedAt" timestamp with time zone,
        "ExpiresAt" timestamp with time zone,
        "SupersedesRequestId" uuid,
        "IsPreApproved" boolean NOT NULL,
        "RenderedManifestsJson" text,
        "GitDeliveryMode" character varying(32) NOT NULL,
        "GitCommitSha" character varying(64),
        "GitPullRequestUrl" character varying(1024),
        "CommittedAt" timestamp with time zone,
        "AppliedAt" timestamp with time zone,
        "LastError" text,
        "RetryCount" integer NOT NULL,
        CONSTRAINT "PK_AccessRequests" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE TABLE "AttestationCampaigns" (
        "Id" uuid NOT NULL,
        "Name" character varying(256) NOT NULL,
        "Description" text,
        "Status" character varying(16) NOT NULL,
        "ClusterName" character varying(256),
        "NamespacesJson" text,
        "IdentityTypesJson" text,
        "MinRiskLevel" character varying(16),
        "OrphansOnly" boolean NOT NULL,
        "ReviewerStrategy" character varying(32) NOT NULL,
        "FixedReviewersJson" text,
        "StartsAt" timestamp with time zone,
        "DueAt" timestamp with time zone,
        "RecurrenceMonths" integer NOT NULL,
        "SnapshotId" uuid,
        "CreatedBy" character varying(256) NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "CompletedAt" timestamp with time zone,
        CONSTRAINT "PK_AttestationCampaigns" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE TABLE "IamClusterSyncStates" (
        "Id" uuid NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "LastSyncStartedAt" timestamp with time zone,
        "LastSyncCompletedAt" timestamp with time zone,
        "LastSuccessfulSyncAt" timestamp with time zone,
        "Health" character varying(16) NOT NULL,
        "LastError" text,
        "IdentityCount" integer NOT NULL,
        "RoleCount" integer NOT NULL,
        "BindingCount" integer NOT NULL,
        "LastSyncDurationMs" integer NOT NULL,
        "IsOpenShift" boolean NOT NULL,
        "SkippedNamespaceCount" integer NOT NULL,
        CONSTRAINT "PK_IamClusterSyncStates" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE TABLE "IamIdentities" (
        "Id" uuid NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Type" character varying(32) NOT NULL,
        "Namespace" character varying(256),
        "Name" character varying(512) NOT NULL,
        "Uid" character varying(64),
        "IsSubjectOnly" boolean NOT NULL,
        "LabelsJson" text,
        "AnnotationsJson" text,
        "SecretRefsJson" text,
        "RiskLevel" character varying(16) NOT NULL,
        "RiskReasonsJson" text,
        "SccNamesJson" text,
        "LdapDn" character varying(1024),
        "DisplayName" character varying(512),
        "Email" character varying(512),
        "LdapDisabled" boolean NOT NULL,
        "LastLoginAt" timestamp with time zone,
        "LastUsedAt" timestamp with time zone,
        "LastUsedSource" character varying(32),
        "CreatedInClusterAt" timestamp with time zone,
        "FirstSeen" timestamp with time zone NOT NULL,
        "LastSeen" timestamp with time zone NOT NULL,
        "DeletedAt" timestamp with time zone,
        "ManagedState" character varying(16) NOT NULL,
        CONSTRAINT "PK_IamIdentities" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE TABLE "IamInventorySnapshots" (
        "Id" uuid NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "TakenAt" timestamp with time zone NOT NULL,
        "Reason" character varying(32) NOT NULL,
        "IdentityCount" integer NOT NULL,
        "RoleCount" integer NOT NULL,
        "BindingCount" integer NOT NULL,
        "EffectivePermissionCount" integer NOT NULL,
        "PayloadJson" text NOT NULL,
        CONSTRAINT "PK_IamInventorySnapshots" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE TABLE "IamSettings" (
        "Id" uuid NOT NULL,
        "FullResyncIntervalHours" integer NOT NULL,
        "SkipProtectedNamespaces" boolean NOT NULL,
        "CollectLoginActivity" boolean NOT NULL,
        "UseAuditLogForLastUsed" boolean NOT NULL,
        "SnapshotRetentionDays" integer NOT NULL,
        "RiskRulesJson" text,
        "ApprovalMatrixJson" text,
        "ApprovalSlaHours" integer NOT NULL,
        "GitDeliveryMode" character varying(32) NOT NULL,
        "GitRootPath" character varying(256) NOT NULL,
        "GitBranch" character varying(256),
        "TrustExternalApprovals" boolean NOT NULL,
        "DriftMode" character varying(16) NOT NULL,
        "DriftExemptionsJson" text,
        "UnusedThresholdDays" integer NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" character varying(256),
        CONSTRAINT "PK_IamSettings" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE TABLE "RbacBindings" (
        "Id" uuid NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Kind" character varying(32) NOT NULL,
        "Namespace" character varying(256),
        "Name" character varying(512) NOT NULL,
        "Uid" character varying(64),
        "RoleRefKind" character varying(32) NOT NULL,
        "RoleRefName" character varying(512) NOT NULL,
        "SubjectsJson" text NOT NULL,
        "ResolvedIdentityKeysJson" text NOT NULL,
        "FirstSeen" timestamp with time zone NOT NULL,
        "LastSeen" timestamp with time zone NOT NULL,
        "DeletedAt" timestamp with time zone,
        "ManagedState" character varying(16) NOT NULL,
        "SourceRequestId" uuid,
        CONSTRAINT "PK_RbacBindings" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE TABLE "RbacRoles" (
        "Id" uuid NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Kind" character varying(32) NOT NULL,
        "Namespace" character varying(256),
        "Name" character varying(512) NOT NULL,
        "Uid" character varying(64),
        "IsAggregated" boolean NOT NULL,
        "RuleCount" integer NOT NULL,
        "HasWildcard" boolean NOT NULL,
        "LabelsJson" text,
        "FirstSeen" timestamp with time zone NOT NULL,
        "LastSeen" timestamp with time zone NOT NULL,
        "DeletedAt" timestamp with time zone,
        "ManagedState" character varying(16) NOT NULL,
        CONSTRAINT "PK_RbacRoles" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE TABLE "ApprovalSteps" (
        "Id" uuid NOT NULL,
        "RequestId" uuid NOT NULL,
        "Order" integer NOT NULL,
        "ApproverRef" character varying(256) NOT NULL,
        "ApproverLabel" character varying(256),
        "Status" character varying(16) NOT NULL,
        "DecidedBy" character varying(256),
        "DecidedAt" timestamp with time zone,
        "Comment" text,
        "DelegatedTo" character varying(256),
        "DueAt" timestamp with time zone,
        CONSTRAINT "PK_ApprovalSteps" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_ApprovalSteps_AccessRequests_RequestId" FOREIGN KEY ("RequestId") REFERENCES "AccessRequests" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE TABLE "AttestationCampaignItems" (
        "Id" uuid NOT NULL,
        "CampaignId" uuid NOT NULL,
        "IdentityId" uuid NOT NULL,
        "IdentityKey" character varying(1024) NOT NULL,
        "IdentityDisplay" character varying(512) NOT NULL,
        "RiskLevel" character varying(16) NOT NULL,
        "PermissionSummaryJson" text NOT NULL,
        "ReviewerRef" character varying(512) NOT NULL,
        "ReviewerDisplayName" character varying(512),
        "Decision" character varying(16) NOT NULL,
        "DecidedBy" character varying(256),
        "DecidedAt" timestamp with time zone,
        "Comment" text,
        "RevokeRequestId" uuid,
        "DelegatedTo" character varying(512),
        CONSTRAINT "PK_AttestationCampaignItems" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_AttestationCampaignItems_AttestationCampaigns_CampaignId" FOREIGN KEY ("CampaignId") REFERENCES "AttestationCampaigns" ("Id") ON DELETE CASCADE,
        CONSTRAINT "FK_AttestationCampaignItems_IamIdentities_IdentityId" FOREIGN KEY ("IdentityId") REFERENCES "IamIdentities" ("Id") ON DELETE RESTRICT
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE TABLE "EffectivePermissions" (
        "Id" uuid NOT NULL,
        "IdentityId" uuid NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "ApiGroup" character varying(256) NOT NULL,
        "Resource" character varying(256) NOT NULL,
        "Verb" character varying(64) NOT NULL,
        "ResourceName" character varying(512),
        "ScopeType" character varying(16) NOT NULL,
        "Namespace" character varying(256),
        "SourceBindingId" uuid,
        "SourceBindingKey" character varying(1024),
        "SourceRoleKey" character varying(1024),
        "IsIndirect" boolean NOT NULL,
        "IndirectVia" character varying(256),
        "FromWildcard" boolean NOT NULL,
        "ComputedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_EffectivePermissions" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_EffectivePermissions_IamIdentities_IdentityId" FOREIGN KEY ("IdentityId") REFERENCES "IamIdentities" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE TABLE "IdentityOwners" (
        "Id" uuid NOT NULL,
        "IdentityId" uuid NOT NULL,
        "OwnerType" character varying(32) NOT NULL,
        "OwnerRef" character varying(512) NOT NULL,
        "OwnerDisplayName" character varying(512),
        "BackupOwnerType" character varying(32),
        "BackupOwnerRef" character varying(512),
        "Source" character varying(16) NOT NULL,
        "SuggestionReason" text,
        "AssignedBy" character varying(256) NOT NULL,
        "AssignedAt" timestamp with time zone NOT NULL,
        "IsStale" boolean NOT NULL,
        CONSTRAINT "PK_IdentityOwners" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_IdentityOwners_IamIdentities_IdentityId" FOREIGN KEY ("IdentityId") REFERENCES "IamIdentities" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE TABLE "WorkloadSaUsages" (
        "Id" uuid NOT NULL,
        "IdentityId" uuid NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Namespace" character varying(256) NOT NULL,
        "WorkloadKind" character varying(64) NOT NULL,
        "WorkloadName" character varying(512) NOT NULL,
        "PodCount" integer NOT NULL,
        "FirstSeenAt" timestamp with time zone NOT NULL,
        "LastSeenAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_WorkloadSaUsages" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_WorkloadSaUsages_IamIdentities_IdentityId" FOREIGN KEY ("IdentityId") REFERENCES "IamIdentities" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE TABLE "RbacRules" (
        "Id" uuid NOT NULL,
        "RoleId" uuid NOT NULL,
        "Ordinal" integer NOT NULL,
        "ApiGroupsJson" text NOT NULL,
        "ResourcesJson" text NOT NULL,
        "VerbsJson" text NOT NULL,
        "ResourceNamesJson" text NOT NULL,
        "NonResourceUrLsJson" text NOT NULL,
        CONSTRAINT "PK_RbacRules" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_RbacRules_RbacRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "RbacRoles" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_AccessRequests_Cluster_Status" ON "AccessRequests" ("ClusterName", "Status");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_AccessRequests_ExpiresAt" ON "AccessRequests" ("ExpiresAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE UNIQUE INDEX "IX_AccessRequests_Reference" ON "AccessRequests" ("Reference");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_AccessRequests_RequestedBy" ON "AccessRequests" ("RequestedBy");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_AccessRequests_Status_CreatedAt" ON "AccessRequests" ("Status", "CreatedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_ApprovalSteps_Request_Order" ON "ApprovalSteps" ("RequestId", "Order");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_ApprovalSteps_Status_DueAt" ON "ApprovalSteps" ("Status", "DueAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_AttestationCampaignItems_Campaign_Decision" ON "AttestationCampaignItems" ("CampaignId", "Decision");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_AttestationCampaignItems_IdentityId" ON "AttestationCampaignItems" ("IdentityId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_AttestationCampaignItems_Reviewer_Decision" ON "AttestationCampaignItems" ("ReviewerRef", "Decision");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_AttestationCampaigns_Status_DueAt" ON "AttestationCampaigns" ("Status", "DueAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_EffectivePermissions_Cluster_Namespace" ON "EffectivePermissions" ("ClusterName", "Namespace");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_EffectivePermissions_Identity" ON "EffectivePermissions" ("IdentityId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_EffectivePermissions_WhoCan" ON "EffectivePermissions" ("ClusterName", "Resource", "Verb");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE UNIQUE INDEX "IX_IamClusterSyncStates_Cluster" ON "IamClusterSyncStates" ("ClusterName");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_IamIdentities_Cluster_Namespace" ON "IamIdentities" ("ClusterName", "Namespace");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_IamIdentities_Cluster_Risk" ON "IamIdentities" ("ClusterName", "RiskLevel");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE UNIQUE INDEX "IX_IamIdentities_Key" ON "IamIdentities" ("ClusterName", "Type", "Namespace", "Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_IamInventorySnapshots_Cluster_TakenAt" ON "IamInventorySnapshots" ("ClusterName", "TakenAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE UNIQUE INDEX "IX_IdentityOwners_Identity" ON "IdentityOwners" ("IdentityId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_IdentityOwners_OwnerRef" ON "IdentityOwners" ("OwnerRef");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_RbacBindings_Cluster_RoleRef" ON "RbacBindings" ("ClusterName", "RoleRefName");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE UNIQUE INDEX "IX_RbacBindings_Key" ON "RbacBindings" ("ClusterName", "Kind", "Namespace", "Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE UNIQUE INDEX "IX_RbacRoles_Key" ON "RbacRoles" ("ClusterName", "Kind", "Namespace", "Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_RbacRules_RoleId" ON "RbacRules" ("RoleId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    CREATE INDEX "IX_WorkloadSaUsages_Identity" ON "WorkloadSaUsages" ("IdentityId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260817074250_AddKubernetesIamGovernance') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260817074250_AddKubernetesIamGovernance', '10.0.7');
    END IF;
END $EF$;

COMMIT;

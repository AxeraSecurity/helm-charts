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
    VALUES ('20260221180953_InitialCreateV2', '10.0.12');
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
    VALUES ('20260224092411_NamespaceAddedForRecords', '10.0.12');
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
    VALUES ('20260317125815_ExclusionListAdded', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260317135613_ExclusionListUpdated') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260317135613_ExclusionListUpdated', '10.0.12');
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
    VALUES ('20260318070959_ExclusionListUpdated2', '10.0.12');
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
    VALUES ('20260327111300_GlobalWhitelistPoliciesAdded', '10.0.12');
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
    VALUES ('20260327123046_GlobalWhitelistJsonRemoved', '10.0.12');
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
    VALUES ('20260331083546_LDAPIntegrationAdded', '10.0.12');
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
    VALUES ('20260401134343_LDAPRoleMappingRelationAdded', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260401142254_LDAPRoleMappingRelationUpdated') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260401142254_LDAPRoleMappingRelationUpdated', '10.0.12');
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
    VALUES ('20260408104731_GitSharedVariableAdded', '10.0.12');
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
    VALUES ('20260413112347_NPWatcherSettingsAdded', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260413112818_NPWatcherSettingsAdded2') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260413112818_NPWatcherSettingsAdded2', '10.0.12');
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
    VALUES ('20260508075252_LicenseInfoExtended', '10.0.12');
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
    VALUES ('20260508113341_PolicyHitAnalytics', '10.0.12');
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
    VALUES ('20260508121319_AnalyticsScopeOptIn', '10.0.12');
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
    VALUES ('20260511120000_MonitoredClusterNodeTelemetry', '10.0.12');
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
        "Actor" text,
        "Action" text NOT NULL,
        "Summary" text NOT NULL,
        "Details" text,
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
    VALUES ('20260512000000_AnalyticsAuditLog', '10.0.12');
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
    VALUES ('20260512100000_PolicyHitDaily', '10.0.12');
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
        "LastEvaluatedAt" timestamp with time zone,
        "LastTriggeredAt" timestamp with time zone,
        "LastValue" double precision,
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
    VALUES ('20260512200000_AnalyticsOverhaul', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512300000_AnalyticsAlertWebhook') THEN
    ALTER TABLE "AnalyticsAlertRules" ADD "WebhookUrl" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512300000_AnalyticsAlertWebhook') THEN
    ALTER TABLE "AnalyticsAlertRules" ADD "WebhookKind" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512300000_AnalyticsAlertWebhook') THEN
    ALTER TABLE "AnalyticsAlertRules" ADD "LastDeliveryAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512300000_AnalyticsAlertWebhook') THEN
    ALTER TABLE "AnalyticsAlertRules" ADD "LastDeliveryOk" boolean;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512300000_AnalyticsAlertWebhook') THEN
    ALTER TABLE "AnalyticsAlertRules" ADD "LastDeliveryError" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260512300000_AnalyticsAlertWebhook') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260512300000_AnalyticsAlertWebhook', '10.0.12');
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
    ALTER TABLE "AnalyticsAlertRules" ADD "SuppressUntil" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260513080000_AnalyticsPolishWaveTwo') THEN
    ALTER TABLE "AnalyticsSavedViews" ADD "DigestRecipients" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260513080000_AnalyticsPolishWaveTwo') THEN
    ALTER TABLE "AnalyticsSavedViews" ADD "DigestCron" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260513080000_AnalyticsPolishWaveTwo') THEN
    ALTER TABLE "AnalyticsSavedViews" ADD "LastDigestSentAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260513080000_AnalyticsPolishWaveTwo') THEN
    ALTER TABLE "AnalyticsSavedViews" ADD "LastDigestOk" boolean;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260513080000_AnalyticsPolishWaveTwo') THEN
    ALTER TABLE "AnalyticsSavedViews" ADD "LastDigestError" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260513080000_AnalyticsPolishWaveTwo') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260513080000_AnalyticsPolishWaveTwo', '10.0.12');
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
    VALUES ('20260513090000_AnalyticsAlertSeverity', '10.0.12');
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
        CONSTRAINT "FK_OcpGroupMappings_OpenShiftIntegrations_OpenShiftIntegrationId" FOREIGN KEY ("OpenShiftIntegrationId") REFERENCES "OpenShiftIntegrations" ("Id") ON DELETE CASCADE
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
    VALUES ('20260514000000_OpenShiftSso', '10.0.12');
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
        "Description" text,
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
        CONSTRAINT "FK_CustomRolePermissions_CustomRoles_CustomRoleId" FOREIGN KEY ("CustomRoleId") REFERENCES "CustomRoles" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    CREATE UNIQUE INDEX "IX_CustomRolePermissions_CustomRoleId_Resource_Scope" ON "CustomRolePermissions" ("CustomRoleId", "Resource", "Scope");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRoles" ("Id", "Name", "Description", "IsBuiltIn", "CreatedAt", "UpdatedAt")
    VALUES ('00000001-0000-0000-0000-000000000001', 'Admin', 'Full administrative control across all resources.', TRUE, TIMESTAMPTZ '2026-05-15T00:00:00Z', TIMESTAMPTZ '2026-05-15T00:00:00Z');
    INSERT INTO "CustomRoles" ("Id", "Name", "Description", "IsBuiltIn", "CreatedAt", "UpdatedAt")
    VALUES ('00000002-0000-0000-0000-000000000002', 'NetworkOperator', 'Manages network policies, integrations, and operational settings; cannot touch user/role administration.', TRUE, TIMESTAMPTZ '2026-05-15T00:00:00Z', TIMESTAMPTZ '2026-05-15T00:00:00Z');
    INSERT INTO "CustomRoles" ("Id", "Name", "Description", "IsBuiltIn", "CreatedAt", "UpdatedAt")
    VALUES ('00000003-0000-0000-0000-000000000003', 'Auditor', 'Read-only visibility across operational data and analytics.', TRUE, TIMESTAMPTZ '2026-05-15T00:00:00Z', TIMESTAMPTZ '2026-05-15T00:00:00Z');
    INSERT INTO "CustomRoles" ("Id", "Name", "Description", "IsBuiltIn", "CreatedAt", "UpdatedAt")
    VALUES ('00000004-0000-0000-0000-000000000004', 'AccessUser', 'Personal dashboard access only; no admin or operational permissions.', TRUE, TIMESTAMPTZ '2026-05-15T00:00:00Z', TIMESTAMPTZ '2026-05-15T00:00:00Z');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('016b3c86-a135-45c1-8353-a519e89aeeec', '00000001-0000-0000-0000-000000000001', 'NetworkPolicy', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('7fac4080-89c3-4331-9e01-9bb1e6de5188', '00000001-0000-0000-0000-000000000001', 'NetworkPolicy', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('329db817-03bc-4231-b229-bd941d9c8014', '00000001-0000-0000-0000-000000000001', 'NetworkPolicy', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('9ebfb6e1-e465-40dd-a5c8-49cdb76c8a9e', '00000001-0000-0000-0000-000000000001', 'GlobalWhitelistPolicy', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('c13a753e-3fdb-4e37-854e-4cbdd7f9c488', '00000001-0000-0000-0000-000000000001', 'GlobalWhitelistPolicy', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('b8530494-674b-40e0-91d2-ea753732ea89', '00000001-0000-0000-0000-000000000001', 'GlobalWhitelistPolicy', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('e534ba01-1699-43f9-9856-9c3248e80d1e', '00000001-0000-0000-0000-000000000001', 'GitProviderSettings', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('1d01eda6-14a9-410b-9be3-28d131e77d97', '00000001-0000-0000-0000-000000000001', 'TicketingProviderSettings', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('47815d7b-07c7-4186-b81b-94991eae7c97', '00000001-0000-0000-0000-000000000001', 'LdapConnection', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('3e527792-dc6a-46e5-8d74-9937986be83a', '00000001-0000-0000-0000-000000000001', 'OpenShiftIntegration', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('c824a8f8-8ffb-4917-856f-fbadb22ca86d', '00000001-0000-0000-0000-000000000001', 'License', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('5274fcf4-c918-4991-aec6-e6107ff2d2bc', '00000001-0000-0000-0000-000000000001', 'License', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('2fe60428-cbca-4585-86f6-338e52d85e18', '00000001-0000-0000-0000-000000000001', 'SetupThirdParty', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('5529d148-9985-4e37-9193-cba19a0164df', '00000001-0000-0000-0000-000000000001', 'SetupThirdParty', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('6ae01f10-cfb3-4386-a6ab-4669d208c732', '00000001-0000-0000-0000-000000000001', 'SetupThirdParty', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('5f7bf753-20e4-4fd6-a20c-2b9fa467dfc8', '00000001-0000-0000-0000-000000000001', 'UserManagement', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('0ed90868-1de5-4927-9375-d3395740bece', '00000001-0000-0000-0000-000000000001', 'UserSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('e8fbbc3c-c633-48de-8397-1518058b9497', '00000001-0000-0000-0000-000000000001', 'UserSettings', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('cdad2289-0371-4c32-9e5d-a93ad14e5214', '00000001-0000-0000-0000-000000000001', 'KubernetesPush', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('6f05df36-1c80-4166-8906-1506f76d33e1', '00000001-0000-0000-0000-000000000001', 'NetworkPolicyFlow', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('4f863180-df2e-46d9-97ff-fc092020492e', '00000001-0000-0000-0000-000000000001', 'Jira', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('34011009-8840-4da7-b6f4-4b24d440696e', '00000001-0000-0000-0000-000000000001', 'Jira', 'Write');
    END IF;
END $EF$;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('46e0b147-c03d-4f88-94aa-a1ca63fc97b9', '00000001-0000-0000-0000-000000000001', 'RadarFlow', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('9692a78e-e13c-4420-ade7-f3ece7b39c90', '00000001-0000-0000-0000-000000000001', 'RadarCollection', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('87ff4332-3479-430a-9e32-1234d490c6c5', '00000001-0000-0000-0000-000000000001', 'RadarCollection', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('73b01b94-6052-4225-9fba-eb961844eddf', '00000001-0000-0000-0000-000000000001', 'RadarCollection', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('f9c8e287-2420-4086-8349-68698bc7a1b9', '00000001-0000-0000-0000-000000000001', 'AllowDropMonitor', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('7133f32d-f674-4933-99ef-0657282782f6', '00000001-0000-0000-0000-000000000001', 'Settings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('6f8968a2-ccad-40cc-be49-2f58f9597c97', '00000001-0000-0000-0000-000000000001', 'Settings', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('65efd718-91be-4bf2-9b7e-13f1f1b67f0c', '00000001-0000-0000-0000-000000000001', 'WatcherSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('58247341-8919-447b-b119-65b78461ce16', '00000001-0000-0000-0000-000000000001', 'WatcherSettings', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('aa45cd9f-a9c5-4cf7-863e-5d6d2ba8989b', '00000001-0000-0000-0000-000000000001', 'Analytics', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('bb8ca09a-beb7-441a-a9ac-7282bc437a3c', '00000001-0000-0000-0000-000000000001', 'Analytics', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('cdd46363-e1df-4ce3-a945-532fa2c5423c', '00000001-0000-0000-0000-000000000001', 'Analytics', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('c2228c22-a3b0-48ef-b1b1-3e28147b53bd', '00000002-0000-0000-0000-000000000002', 'NetworkPolicy', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('628245d2-01db-4e21-8b0a-ef193ae63e9d', '00000002-0000-0000-0000-000000000002', 'NetworkPolicy', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('1e127d21-509b-4f1b-bf30-ccb92b560a2c', '00000002-0000-0000-0000-000000000002', 'NetworkPolicy', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('c92633d3-8585-49fa-b340-d65d8d73d731', '00000002-0000-0000-0000-000000000002', 'GlobalWhitelistPolicy', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('0faf6930-d579-44fb-84c7-ff397d81c8e4', '00000002-0000-0000-0000-000000000002', 'GlobalWhitelistPolicy', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('cd9c8633-2231-44f1-8f52-ae1dfb684cfd', '00000002-0000-0000-0000-000000000002', 'GlobalWhitelistPolicy', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('9f6020b7-577f-4218-a953-ef520de27e7d', '00000002-0000-0000-0000-000000000002', 'GitProviderSettings', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('39ee0ca6-3eb1-4101-92f7-1d1da64aa601', '00000002-0000-0000-0000-000000000002', 'TicketingProviderSettings', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('40f44bac-c116-4f90-98db-1566a3e31024', '00000002-0000-0000-0000-000000000002', 'SetupThirdParty', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('5bcd2e45-1a8e-4a4b-aee2-cd5cad733f4f', '00000002-0000-0000-0000-000000000002', 'UserSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('361cdd70-16a7-4ead-9d0f-909184e10547', '00000002-0000-0000-0000-000000000002', 'UserSettings', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('be58719d-a9f6-40c8-a31a-3b36485e15c4', '00000002-0000-0000-0000-000000000002', 'KubernetesPush', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('4d40141b-57e6-4b5f-ba76-e0747ee1a516', '00000002-0000-0000-0000-000000000002', 'NetworkPolicyFlow', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('2b47a654-d69e-44e9-8297-a5d42cacb6aa', '00000002-0000-0000-0000-000000000002', 'Jira', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('2c15933e-9a02-44ba-9cc0-dbfd49d19ba2', '00000002-0000-0000-0000-000000000002', 'Jira', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('6a7ffdce-55cc-4293-bafb-c33046638066', '00000002-0000-0000-0000-000000000002', 'RadarFlow', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('e271d855-5170-410e-a346-4f40a87b5b1b', '00000002-0000-0000-0000-000000000002', 'RadarCollection', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('5bcdb435-61d0-4c92-ade5-0e328e4c2a4e', '00000002-0000-0000-0000-000000000002', 'RadarCollection', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('f0bb8063-454e-47e1-99da-936521fcd9b0', '00000002-0000-0000-0000-000000000002', 'RadarCollection', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('f86f66dd-0054-435a-a587-13868c7828de', '00000002-0000-0000-0000-000000000002', 'AllowDropMonitor', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('5c5f990f-c4dc-48d6-9ccb-922e7b5b92cd', '00000002-0000-0000-0000-000000000002', 'Settings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('240619a5-949b-4222-96b0-e5c0a3911b89', '00000002-0000-0000-0000-000000000002', 'WatcherSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('d59d776f-57cb-42e2-908a-f4b3f609fb5b', '00000002-0000-0000-0000-000000000002', 'Analytics', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('e9679c26-8d5d-42b8-9a73-87bf1319714c', '00000002-0000-0000-0000-000000000002', 'Analytics', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('276be16c-c942-47de-bb66-97e5dfe26e3e', '00000002-0000-0000-0000-000000000002', 'Analytics', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('6a008fa4-8d19-4934-a5de-71afcd6a5444', '00000003-0000-0000-0000-000000000003', 'SetupThirdParty', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('f23c5679-47f3-4c39-bb3a-442de596f764', '00000003-0000-0000-0000-000000000003', 'UserSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('47c53030-f807-4b0a-b73c-5f4f73f5a19a', '00000003-0000-0000-0000-000000000003', 'UserSettings', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('a45a33be-90c1-4c0a-a29a-ffee4cb3d2a1', '00000003-0000-0000-0000-000000000003', 'Jira', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('6f1506ef-5b34-4999-87e2-401369a54235', '00000003-0000-0000-0000-000000000003', 'RadarFlow', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('ff93dd0a-370c-41f2-9a20-4a834a0afe4d', '00000003-0000-0000-0000-000000000003', 'RadarCollection', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('7808203e-f73d-46b5-9009-8767ae459893', '00000003-0000-0000-0000-000000000003', 'AllowDropMonitor', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('95c8baf8-e133-497c-afeb-f96e6f555b67', '00000003-0000-0000-0000-000000000003', 'WatcherSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('9f8ca178-29a1-46bc-8221-f29764f2edc6', '00000003-0000-0000-0000-000000000003', 'Analytics', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('0c7db47b-c924-4632-b43b-ade91e05258c', '00000004-0000-0000-0000-000000000004', 'SetupThirdParty', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('11c16ef3-c7a2-48ff-bb14-36fe814d2cb8', '00000004-0000-0000-0000-000000000004', 'UserSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('ec9a5bab-ee01-4005-a095-78db910bf0aa', '00000004-0000-0000-0000-000000000004', 'UserSettings', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('3f52f17e-a5f7-4c28-9ac6-54f88cede8a9', '00000004-0000-0000-0000-000000000004', 'RadarFlow', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('84d56412-d9f9-4be8-85e6-6d6522e7f960', '00000004-0000-0000-0000-000000000004', 'RadarCollection', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('4826e0ea-cec0-46aa-b548-63d1f8da335b', '00000004-0000-0000-0000-000000000004', 'AllowDropMonitor', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('4c10e86e-cfbe-4127-aefa-afb0ef2a0854', '00000004-0000-0000-0000-000000000004', 'WatcherSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260515000000_CustomRoleBuilder', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521000000_AuditOverhaul') THEN
    CREATE TABLE "AuditEntries" (
        "Id" uuid NOT NULL,
        "At" timestamp with time zone NOT NULL,
        "Actor" text,
        "Category" text NOT NULL,
        "Action" text NOT NULL,
        "Summary" text NOT NULL,
        "Details" text,
        "ForwardedAt" timestamp with time zone,
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
    CREATE INDEX "IX_AuditEntries_ForwardedAt_pending" ON "AuditEntries" ("At") WHERE "ForwardedAt" IS NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521000000_AuditOverhaul') THEN
    CREATE TABLE "SiemSettings" (
        "Id" uuid NOT NULL,
        "Enabled" boolean NOT NULL,
        "Protocol" integer NOT NULL,
        "EndpointUrl" text,
        "Token" text,
        "Index" text,
        "SyslogHost" text,
        "SyslogPort" integer,
        "AppName" text,
        "ForwardAuditLogs" boolean NOT NULL,
        "ForwardPolicyMonitoringLogs" boolean NOT NULL,
        "AllowInsecureTls" boolean NOT NULL,
        "RetentionDays" integer NOT NULL DEFAULT 90,
        "PolicyMonitoringForwardedThrough" timestamp with time zone,
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" text,
        CONSTRAINT "PK_SiemSettings" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521000000_AuditOverhaul') THEN

                    INSERT INTO "AuditEntries" ("Id", "At", "Actor", "Category", "Action", "Summary", "Details", "ForwardedAt")
                    SELECT "Id", "At", "Actor", 'Analytics', "Action", "Summary", "Details", NULL
                    FROM "AnalyticsAuditEntries"
                    ON CONFLICT DO NOTHING;
                
    END IF;
END $EF$;

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
    VALUES ('20260521000000_AuditOverhaul', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521020000_SiemRetention') THEN
    ALTER TABLE "SiemSettings" ADD COLUMN IF NOT EXISTS "RetentionDays" integer NOT NULL DEFAULT 90;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521020000_SiemRetention') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260521020000_SiemRetention', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521030000_SiemCategoryFilter') THEN
    ALTER TABLE "SiemSettings" ADD COLUMN IF NOT EXISTS "ForwardedAuditCategories" text[];
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260521030000_SiemCategoryFilter') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260521030000_SiemCategoryFilter', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    ALTER TABLE "SiemSettings" ADD COLUMN IF NOT EXISTS "ForwardIncidents" boolean NOT NULL DEFAULT TRUE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    ALTER TABLE "SiemSettings" ADD COLUMN IF NOT EXISTS "IncidentsForwardedThrough" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    CREATE TABLE "Incidents" (
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
    CREATE INDEX "IX_Incidents_CorrelationKey_Active" ON "Incidents" ("CorrelationKey");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    CREATE INDEX "IX_Incidents_LastSeenAt" ON "Incidents" ("LastSeenAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    CREATE INDEX "IX_Incidents_ForwardedAt" ON "Incidents" ("ForwardedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    CREATE TABLE "IncidentEvents" (
        "Id" uuid NOT NULL,
        "IncidentId" uuid NOT NULL,
        "At" timestamp with time zone NOT NULL,
        "Payload" text,
        CONSTRAINT "PK_IncidentEvents" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_IncidentEvents_Incidents_IncidentId" FOREIGN KEY ("IncidentId") REFERENCES "Incidents" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    CREATE INDEX "IX_IncidentEvents_Incident_At" ON "IncidentEvents" ("IncidentId", "At");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    CREATE TABLE "ThreatIntelSettings" (
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

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN
    CREATE TABLE "ThreatIntelFeeds" (
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
    CREATE UNIQUE INDEX "IX_ThreatIntelFeeds_Key" ON "ThreatIntelFeeds" ("Key");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN

                    INSERT INTO "ThreatIntelFeeds"
                        ("Id", "Key", "DisplayName", "Kind", "Url", "Enabled", "IsBuiltIn", "EntryCount", "CreatedAt")
                    VALUES
                        (gen_random_uuid(), 'firehol-level1', 'FireHOL Level1 (high-confidence malicious networks)', 0,
                         'https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level1.netset',
                         true, true, 0, now()),
                        (gen_random_uuid(), 'feodo-tracker', 'abuse.ch Feodo Tracker (active botnet C2)', 0,
                         'https://feodotracker.abuse.ch/downloads/ipblocklist.txt',
                         true, true, 0, now()),
                        (gen_random_uuid(), 'urlhaus', 'abuse.ch URLhaus (malware-hosting domains)', 1,
                         'https://urlhaus.abuse.ch/downloads/text/',
                         true, true, 0, now()),
                        (gen_random_uuid(), 'tor-exit', 'Tor Project exit-node list', 0,
                         'https://check.torproject.org/torbulkexitlist',
                         false, true, 0, now())
                    ON CONFLICT DO NOTHING;
                
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260522000000_IncidentsAndThreatIntel') THEN

                    INSERT INTO "ThreatIntelSettings"
                        ("Id", "Enabled", "IpReputationEnabled", "DnsThreatEnabled",
                         "LateralMovementEnabled", "AllowInsecureTls",
                         "ProviderHighSeverityThreshold", "CorrelationWindowMinutes",
                         "UpdatedAt")
                    SELECT gen_random_uuid(), true, true, true, true, false, 50, 15, now()
                    WHERE NOT EXISTS (SELECT 1 FROM "ThreatIntelSettings");
                
    END IF;
END $EF$;

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
    VALUES ('20260522000000_IncidentsAndThreatIntel', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260523000000_ThreatIntelExclusions') THEN
    CREATE TABLE "ThreatIntelExclusions" (
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
    CREATE INDEX "IX_ThreatIntelExclusions_Namespace" ON "ThreatIntelExclusions" ("Namespace");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260523000000_ThreatIntelExclusions') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260523000000_ThreatIntelExclusions', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260524000000_IncidentNotificationChannels') THEN
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "BeaconingEnabled" boolean NOT NULL DEFAULT TRUE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260524000000_IncidentNotificationChannels') THEN
    CREATE TABLE "IncidentNotificationChannels" (
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
    CREATE TABLE "IncidentSavedViews" (
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
    CREATE INDEX "IX_IncidentSavedViews_Owner" ON "IncidentSavedViews" ("Owner");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260524000000_IncidentNotificationChannels') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260524000000_IncidentNotificationChannels', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525000000_ManualNetworkPolicies') THEN
    CREATE TABLE "ManualNetworkPolicies" (
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
    CREATE INDEX "IX_ManualNetworkPolicies_UploadBatchId" ON "ManualNetworkPolicies" ("UploadBatchId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525000000_ManualNetworkPolicies') THEN
    CREATE INDEX "IX_ManualNetworkPolicies_ApprovalStatus" ON "ManualNetworkPolicies" ("ApprovalStatus");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525000000_ManualNetworkPolicies') THEN
    CREATE INDEX "IX_ManualNetworkPolicies_ClusterName_Namespace" ON "ManualNetworkPolicies" ("ClusterName", "Namespace");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525000000_ManualNetworkPolicies') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260525000000_ManualNetworkPolicies', '10.0.12');
    END IF;
END $EF$;
COMMIT;

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
    VALUES ('20260525010000_ManualNetworkPolicyRbac', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    DROP INDEX "IX_ManualNetworkPolicies_ApprovalStatus";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    DROP INDEX "IX_ManualNetworkPolicies_ClusterName_Namespace";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    DROP INDEX "IX_ManualNetworkPolicies_UploadBatchId";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    DROP INDEX "IX_AuditEntries_At";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    DROP INDEX "IX_AuditEntries_Category";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    DROP INDEX "IX_AnalyticsSavedViews_OwnerUserId";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    DROP INDEX "IX_AnalyticsAuditEntries_At";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    DROP INDEX "IX_AnalyticsAlertRules_OwnerUserId";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "SiemSettings" ALTER COLUMN "RetentionDays" DROP DEFAULT;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "OpenShiftIntegrations" ALTER COLUMN "IsEnabled" DROP DEFAULT;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "UploadedBy" TYPE text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "SourceFileName" TYPE text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "Source" TYPE text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "RejectionReason" TYPE text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "RejectedBy" TYPE text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "Protocol" TYPE text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "Namespace" TYPE text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "Name" TYPE text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "Direction" TYPE text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "Destination" TYPE text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "Description" TYPE text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "ClusterName" TYPE text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "ApprovedBy" TYPE text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "ManualNetworkPolicies" ALTER COLUMN "ApprovalStatus" TYPE text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "CustomRoles" ALTER COLUMN "IsBuiltIn" DROP DEFAULT;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "AnalyticsAlertRules" ALTER COLUMN "SuppressMinutes" DROP DEFAULT;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "AnalyticsAlertRules" ALTER COLUMN "Severity" DROP DEFAULT;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    ALTER TABLE "AnalyticsAlertRules" ALTER COLUMN "ClusterId" DROP DEFAULT;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260525103259_ThreatIntelAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260525103259_ThreatIntelAdded', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260601140000_AiSettingsAdded') THEN
    CREATE TABLE "AiSettings" (
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
    VALUES ('20260601140000_AiSettingsAdded', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260603120000_AiPolicyAdvisoryAdded') THEN
    ALTER TABLE "AiSettings" ADD "PolicyAdvisoryEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260603120000_AiPolicyAdvisoryAdded') THEN
    ALTER TABLE "AiSettings" ADD "PolicyAdvisoryIntervalHours" integer NOT NULL DEFAULT 24;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260603120000_AiPolicyAdvisoryAdded') THEN
    ALTER TABLE "AiSettings" ADD "PolicyAdvisoryMaxPolicies" integer NOT NULL DEFAULT 60;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260603120000_AiPolicyAdvisoryAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260603120000_AiPolicyAdvisoryAdded', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260603130000_IncidentMitreAndScore') THEN
    ALTER TABLE "Incidents" ADD "MitreTechnique" character varying(32);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260603130000_IncidentMitreAndScore') THEN
    ALTER TABLE "Incidents" ADD "Score" integer;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260603130000_IncidentMitreAndScore') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260603130000_IncidentMitreAndScore', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260604130000_NetworkPolicyDeploymentState') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "DeploymentState" character varying(32) NOT NULL DEFAULT 'Draft';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260604130000_NetworkPolicyDeploymentState') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "LastDeployedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260604130000_NetworkPolicyDeploymentState') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260604130000_NetworkPolicyDeploymentState', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260608120000_ShiftLeftAdded') THEN
    CREATE TABLE "ScanRepositories" (
        "Id" uuid NOT NULL,
        "Provider" character varying(32) NOT NULL,
        "RepositoryUrl" character varying(1024) NOT NULL,
        "Owner" character varying(256),
        "Name" character varying(256),
        "Branch" character varying(256) NOT NULL,
        "PathGlobs" text,
        "TargetClusterName" character varying(256),
        "TargetNamespace" character varying(256),
        "AnalyzeManifests" boolean NOT NULL,
        "AnalyzeDockerfile" boolean NOT NULL,
        "AnalyzeCodeWithAi" boolean NOT NULL,
        "Enabled" boolean NOT NULL,
        "ScheduledScanEnabled" boolean NOT NULL,
        "ScanIntervalHours" integer NOT NULL,
        "LastScanAt" timestamp with time zone,
        "LastScanStatus" character varying(32),
        "LastCommitSha" character varying(64),
        "CreatedAt" timestamp with time zone NOT NULL,
        "CreatedBy" character varying(256),
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" character varying(256),
        CONSTRAINT "PK_ScanRepositories" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260608120000_ShiftLeftAdded') THEN
    CREATE TABLE "RepositoryScans" (
        "Id" uuid NOT NULL,
        "ScanRepositoryId" uuid NOT NULL,
        "Status" character varying(32) NOT NULL,
        "Trigger" character varying(16) NOT NULL,
        "CommitSha" character varying(64),
        "StartedAt" timestamp with time zone NOT NULL,
        "CompletedAt" timestamp with time zone,
        "IntentCount" integer NOT NULL,
        "RecommendationCount" integer NOT NULL,
        "Error" text,
        "TriggeredBy" character varying(256),
        CONSTRAINT "PK_RepositoryScans" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_RepositoryScans_ScanRepositories_ScanRepositoryId" FOREIGN KEY ("ScanRepositoryId") REFERENCES "ScanRepositories" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260608120000_ShiftLeftAdded') THEN
    CREATE TABLE "PolicyIntents" (
        "Id" uuid NOT NULL,
        "RepositoryScanId" uuid NOT NULL,
        "SrcWorkload" character varying(256) NOT NULL,
        "SrcNamespace" character varying(256) NOT NULL,
        "DstWorkload" character varying(256),
        "DstNamespace" character varying(256),
        "DstExternal" boolean NOT NULL,
        "DstHost" character varying(512),
        "Port" integer NOT NULL,
        "Protocol" character varying(16) NOT NULL,
        "Direction" character varying(16) NOT NULL,
        "Confidence" integer NOT NULL,
        "Analyzer" character varying(16) NOT NULL,
        "EvidenceFile" character varying(1024),
        "EvidenceLine" integer,
        "EvidenceCommit" character varying(64),
        "EvidenceSnippet" character varying(2000),
        CONSTRAINT "PK_PolicyIntents" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_PolicyIntents_RepositoryScans_RepositoryScanId" FOREIGN KEY ("RepositoryScanId") REFERENCES "RepositoryScans" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260608120000_ShiftLeftAdded') THEN
    CREATE TABLE "PolicyRecommendations" (
        "Id" uuid NOT NULL,
        "ScanRepositoryId" uuid NOT NULL,
        "RepositoryScanId" uuid NOT NULL,
        "ClusterName" character varying(256),
        "TargetNamespace" character varying(256),
        "TargetWorkload" character varying(256),
        "PolicyName" character varying(256) NOT NULL,
        "PolicyYaml" text,
        "Confidence" integer NOT NULL,
        "Summary" text,
        "Status" character varying(16) NOT NULL,
        "NetworkPolicyRecordId" uuid,
        "CreatedAt" timestamp with time zone NOT NULL,
        "DecidedAt" timestamp with time zone,
        "DecidedBy" character varying(256),
        CONSTRAINT "PK_PolicyRecommendations" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260608120000_ShiftLeftAdded') THEN
    CREATE UNIQUE INDEX "IX_ScanRepositories_Url_Branch" ON "ScanRepositories" ("RepositoryUrl", "Branch");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260608120000_ShiftLeftAdded') THEN
    CREATE INDEX "IX_RepositoryScans_ScanRepositoryId" ON "RepositoryScans" ("ScanRepositoryId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260608120000_ShiftLeftAdded') THEN
    CREATE INDEX "IX_PolicyIntents_RepositoryScanId" ON "PolicyIntents" ("RepositoryScanId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260608120000_ShiftLeftAdded') THEN
    CREATE INDEX "IX_PolicyRecommendations_ScanRepositoryId" ON "PolicyRecommendations" ("ScanRepositoryId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260608120000_ShiftLeftAdded') THEN
    CREATE INDEX "IX_PolicyRecommendations_RepositoryScanId" ON "PolicyRecommendations" ("RepositoryScanId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260608120000_ShiftLeftAdded') THEN
    CREATE INDEX "IX_PolicyRecommendations_Status" ON "PolicyRecommendations" ("Status");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260608120000_ShiftLeftAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260608120000_ShiftLeftAdded', '10.0.12');
    END IF;
END $EF$;
COMMIT;

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
        "ApiKey" character varying(1024),
        "ApiVersion" character varying(64),
        "TimeoutSeconds" integer NOT NULL,
        "Temperature" double precision NOT NULL,
        "MaxTokens" integer NOT NULL,
        "Enabled" boolean NOT NULL,
        "IsDefault" boolean NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" character varying(256),
        CONSTRAINT "PK_AiModelConfigs" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260609120000_AiMultiProviderAdded') THEN
    CREATE TABLE "AiFeatureRoutes" (
        "Id" uuid NOT NULL,
        "Feature" character varying(64) NOT NULL,
        "AiModelConfigId" uuid NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" character varying(256),
        CONSTRAINT "PK_AiFeatureRoutes" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_AiFeatureRoutes_AiModelConfigs_AiModelConfigId" FOREIGN KEY ("AiModelConfigId") REFERENCES "AiModelConfigs" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260609120000_AiMultiProviderAdded') THEN
    CREATE UNIQUE INDEX "IX_AiModelConfigs_Name" ON "AiModelConfigs" ("Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260609120000_AiMultiProviderAdded') THEN
    CREATE UNIQUE INDEX "IX_AiFeatureRoutes_Feature" ON "AiFeatureRoutes" ("Feature");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260609120000_AiMultiProviderAdded') THEN
    CREATE INDEX "IX_AiFeatureRoutes_AiModelConfigId" ON "AiFeatureRoutes" ("AiModelConfigId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260609120000_AiMultiProviderAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260609120000_AiMultiProviderAdded', '10.0.12');
    END IF;
END $EF$;
COMMIT;

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
    VALUES ('20260701170428_ProtectedNamespaceSettingsAdded', '10.0.12');
    END IF;
END $EF$;
COMMIT;

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
    VALUES ('20260703120841_DataProtectionKeysAdded', '10.0.12');
    END IF;
END $EF$;
COMMIT;

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
    VALUES ('20260710131804_SiemPolicyHitForwardedAndIncidentDedup', '10.0.12');
    END IF;
END $EF$;
COMMIT;

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
    VALUES ('20260716085021_BackupAndRestore', '10.0.12');
    END IF;
END $EF$;
COMMIT;

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
    ALTER TABLE "SiemDestinations" ADD COLUMN IF NOT EXISTS "CaCert" text;
    CREATE UNIQUE INDEX IF NOT EXISTS "IX_SiemDestinations_Name" ON "SiemDestinations" ("Name");
    CREATE UNIQUE INDEX IF NOT EXISTS "IX_SiemDestinations_IsDefault" ON "SiemDestinations" ("IsDefault") WHERE "IsDefault" = true;

    ALTER TABLE "SiemSettings" ADD COLUMN IF NOT EXISTS "AuditDestinationId" uuid;
    ALTER TABLE "SiemSettings" ADD COLUMN IF NOT EXISTS "PolicyMonitoringDestinationId" uuid;
    ALTER TABLE "SiemSettings" ADD COLUMN IF NOT EXISTS "IncidentsDestinationId" uuid;

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
    VALUES ('20260720140022_SiemDestinations', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

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
    VALUES ('20260721084748_AddLicenseEdition', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

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
    VALUES ('20260721121642_AddIncidentProcessAttribution', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721122551_AddDeniedSprayDetectorSetting') THEN
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "DeniedSprayEnabled" boolean NOT NULL DEFAULT true;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721122551_AddDeniedSprayDetectorSetting') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260721122551_AddDeniedSprayDetectorSetting', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

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
    VALUES ('20260721123923_AddMeshDenyDetectorSetting', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721195257_AddWorkloadCriticality') THEN
    CREATE TABLE "WorkloadCriticalities" (
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
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721195257_AddWorkloadCriticality') THEN
    CREATE UNIQUE INDEX "IX_WorkloadCriticalities_Identity" ON "WorkloadCriticalities" ("ClusterName", "Namespace", "Workload");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721195257_AddWorkloadCriticality') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260721195257_AddWorkloadCriticality', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260721203248_AddRadarStateSnapshot') THEN
    CREATE TABLE "RadarStateSnapshots" (
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
    VALUES ('20260721203248_AddRadarStateSnapshot', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

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
    VALUES ('20260721215347_AddIncidentL4Protocol', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

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
    VALUES ('20260721220655_AddDetectionTuningSettings', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

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
    VALUES ('20260722111249_AddPolicySoftDeleteRetention', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    ALTER TABLE "Incidents" ADD "ContainedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    ALTER TABLE "Incidents" ADD "ContainedBy" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    ALTER TABLE "Incidents" ADD "ContainmentExpiresAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    ALTER TABLE "Incidents" ADD "ContainmentLiftedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    ALTER TABLE "Incidents" ADD "ContainmentLiftedReason" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    ALTER TABLE "Incidents" ADD "ContainmentPolicyName" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    ALTER TABLE "Incidents" ADD "ContainmentPolicyRecordId" uuid;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    ALTER TABLE "AnalyticsSettings" ADD "ContainmentDefaultTtlHours" integer NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260803135130_AddIncidentContainment') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260803135130_AddIncidentContainment', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805070111_AddContainmentActionsAndSrcPrincipal') THEN
    ALTER TABLE "Incidents" ADD "SrcPrincipal" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805070111_AddContainmentActionsAndSrcPrincipal') THEN
    CREATE TABLE "ContainmentActions" (
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
    CREATE INDEX "IX_ContainmentActions_Incident_Status" ON "ContainmentActions" ("IncidentId", "Status");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805070111_AddContainmentActionsAndSrcPrincipal') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260805070111_AddContainmentActionsAndSrcPrincipal', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805072730_AddResponsePlaybooks') THEN
    CREATE TABLE "IncidentResponsePlaybooks" (
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
    CREATE TABLE "PlaybookExecutions" (
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
    CREATE INDEX "IX_IncidentResponsePlaybooks_Enabled_Priority" ON "IncidentResponsePlaybooks" ("Enabled", "Priority");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805072730_AddResponsePlaybooks') THEN
    CREATE INDEX "IX_PlaybookExecutions_IncidentId" ON "PlaybookExecutions" ("IncidentId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805072730_AddResponsePlaybooks') THEN
    CREATE INDEX "IX_PlaybookExecutions_MatchedAt" ON "PlaybookExecutions" ("MatchedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805072730_AddResponsePlaybooks') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260805072730_AddResponsePlaybooks', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805073750_AddAutoResponseSettings') THEN
    ALTER TABLE "AnalyticsSettings" ADD "AutoResponseEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805073750_AddAutoResponseSettings') THEN
    ALTER TABLE "AnalyticsSettings" ADD "AutoResponseMode" text NOT NULL DEFAULT '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805073750_AddAutoResponseSettings') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260805073750_AddAutoResponseSettings', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805074650_AddThreatIntelEgressBlock') THEN
    ALTER TABLE "AnalyticsSettings" ADD "ThreatIntelEgressBlockEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805074650_AddThreatIntelEgressBlock') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260805074650_AddThreatIntelEgressBlock', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805123625_AddContainmentVerification') THEN
    ALTER TABLE "Incidents" ADD "FlowLastSeenAfterContainAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805123625_AddContainmentVerification') THEN
    ALTER TABLE "Incidents" ADD "LastVerifiedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805123625_AddContainmentVerification') THEN
    ALTER TABLE "Incidents" ADD "VerificationStatus" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805123625_AddContainmentVerification') THEN
    ALTER TABLE "Incidents" ADD "VerifiedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805123625_AddContainmentVerification') THEN
    ALTER TABLE "AnalyticsSettings" ADD "ContainmentAutoReopenOnResume" boolean NOT NULL DEFAULT TRUE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805123625_AddContainmentVerification') THEN
    ALTER TABLE "AnalyticsSettings" ADD "ContainmentVerifyGraceMinutes" integer NOT NULL DEFAULT 15;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260805123625_AddContainmentVerification') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260805123625_AddContainmentVerification', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807135208_AddCloudMetadataAbuseSetting') THEN
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "CloudMetadataAbuseEnabled" boolean NOT NULL DEFAULT true;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807135208_AddCloudMetadataAbuseSetting') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260807135208_AddCloudMetadataAbuseSetting', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807142835_AddIncidentReplicaFusion') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "ReplicaCount" integer NOT NULL DEFAULT 1;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807142835_AddIncidentReplicaFusion') THEN
    ALTER TABLE "Incidents" ADD COLUMN IF NOT EXISTS "ReplicaKeys" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807142835_AddIncidentReplicaFusion') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260807142835_AddIncidentReplicaFusion', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807143956_AddTlsFingerprintSecretReadSettings') THEN
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "TlsFingerprintEnabled" boolean NOT NULL DEFAULT true;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807143956_AddTlsFingerprintSecretReadSettings') THEN
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "SecretReadEnabled" boolean NOT NULL DEFAULT true;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807143956_AddTlsFingerprintSecretReadSettings') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260807143956_AddTlsFingerprintSecretReadSettings', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

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
    VALUES ('20260807145318_AddKubeAuditSetting', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807145834_AddWorkloadImagePosture') THEN
    CREATE TABLE "WorkloadImagePostures" (
        "Id" uuid NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Namespace" character varying(256) NOT NULL,
        "Workload" character varying(256) NOT NULL,
        "Image" character varying(1024) NOT NULL,
        "ImageDigest" character varying(256),
        "CriticalCves" integer NOT NULL,
        "HighCves" integer NOT NULL,
        "MediumCves" integer NOT NULL,
        "LowCves" integer NOT NULL,
        "FixableCves" integer NOT NULL,
        "TopCveIds" character varying(2048),
        "Scanner" character varying(64),
        "ScannedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_WorkloadImagePostures" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807145834_AddWorkloadImagePosture') THEN
    CREATE UNIQUE INDEX "IX_WorkloadImagePostures_Identity" ON "WorkloadImagePostures" ("ClusterName", "Namespace", "Workload", "Image");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260807145834_AddWorkloadImagePosture') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260807145834_AddWorkloadImagePosture', '10.0.12');
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
    VALUES ('20260813093542_AddCaptureSessions', '10.0.12');
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
    VALUES ('20260813100436_AddCaptureLabelSelectors', '10.0.12');
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
    VALUES ('20260813110209_AddCaptureActivePerClusterUniqueIndex', '10.0.12');
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
    VALUES ('20260813111830_AddCaptureIncidentLink', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819094648_AddNetworkPolicyModifiedBy') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "LastModifiedBy" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819094648_AddNetworkPolicyModifiedBy') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "LastModifiedByGroups" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819094648_AddNetworkPolicyModifiedBy') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "LastModifiedVia" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819094648_AddNetworkPolicyModifiedBy') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260819094648_AddNetworkPolicyModifiedBy', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819121603_AddNetworkPolicyModifiedAudit') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "LastModifiedAudit" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819121603_AddNetworkPolicyModifiedAudit') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260819121603_AddNetworkPolicyModifiedAudit', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819124356_AddNetworkPolicyLastAttributedAt') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "LastAttributedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819124356_AddNetworkPolicyLastAttributedAt') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260819124356_AddNetworkPolicyLastAttributedAt', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260825100246_EgressRuleIntentsAdded') THEN
    CREATE TABLE "EgressRuleIntents" (
        "Id" uuid NOT NULL,
        "Name" text NOT NULL,
        "ClusterName" text NOT NULL,
        "Namespace" text NOT NULL,
        "Workload" text NOT NULL,
        "AllowedDomains" text NOT NULL,
        "AllowedCidrs" text NOT NULL,
        "AllowedPorts" text NOT NULL,
        "Description" text NOT NULL,
        "Status" text NOT NULL,
        "RenderedFor" text NOT NULL,
        "CreatedBy" text NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_EgressRuleIntents" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260825100246_EgressRuleIntentsAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260825100246_EgressRuleIntentsAdded', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260827120221_AiRunLedgerAdded') THEN
    CREATE TABLE "AiRuns" (
        "Id" uuid NOT NULL,
        "Feature" character varying(64) NOT NULL,
        "TargetKind" character varying(32),
        "TargetId" character varying(256),
        "ConfigId" uuid,
        "ConfigName" character varying(128),
        "Provider" character varying(64),
        "Model" character varying(256),
        "Status" character varying(32) NOT NULL,
        "Error" character varying(2048),
        "ResponseRaw" text,
        "PromptChars" integer NOT NULL,
        "PromptTokens" integer,
        "CompletionTokens" integer,
        "DurationMs" bigint,
        "PromptTruncated" boolean NOT NULL,
        "PromptHash" character varying(64),
        "StartedAt" timestamp with time zone NOT NULL,
        "FinishedAt" timestamp with time zone NOT NULL,
        "TriggeredBy" character varying(256),
        CONSTRAINT "PK_AiRuns" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260827120221_AiRunLedgerAdded') THEN
    CREATE INDEX "IX_AiRuns_Feature_StartedAt" ON "AiRuns" ("Feature", "StartedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260827120221_AiRunLedgerAdded') THEN
    CREATE INDEX "IX_AiRuns_StartedAt" ON "AiRuns" ("StartedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260827120221_AiRunLedgerAdded') THEN
    CREATE INDEX "IX_AiRuns_TargetKind_TargetId_StartedAt" ON "AiRuns" ("TargetKind", "TargetId", "StartedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260827120221_AiRunLedgerAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260827120221_AiRunLedgerAdded', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260827193501_AiRunUsabilityAdded') THEN
    ALTER TABLE "AiRuns" ADD "Usable" boolean;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260827193501_AiRunUsabilityAdded') THEN
    ALTER TABLE "AiRuns" ADD "UsableNote" character varying(512);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260827193501_AiRunUsabilityAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260827193501_AiRunUsabilityAdded', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260827202540_IncidentCorrelationHistoryIndexAdded') THEN
    CREATE INDEX "IX_Incidents_CorrelationKey_History" ON "Incidents" ("CorrelationKey", "LastSeenAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260827202540_IncidentCorrelationHistoryIndexAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260827202540_IncidentCorrelationHistoryIndexAdded', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260905065325_IncidentSeverityPinned') THEN
    ALTER TABLE "Incidents" ADD "SeverityPinned" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260905065325_IncidentSeverityPinned') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260905065325_IncidentSeverityPinned', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260905072712_IncidentDismissedAt') THEN
    ALTER TABLE "Incidents" ADD "DismissedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260905072712_IncidentDismissedAt') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260905072712_IncidentDismissedAt', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260911081954_MeshPolicyRbac') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    SELECT gen_random_uuid(), g.role_id, 'MeshPolicy', g.mesh_scope
    FROM (
        SELECT DISTINCT np."CustomRoleId" AS role_id, m.mesh_scope
        FROM "CustomRolePermissions" np
        JOIN (VALUES
            ('Read', 'Read'),
            ('Write', 'Write'),
            ('Delete', 'Delete'),
            ('Manage', 'Manage')
        ) AS m(np_scope, mesh_scope) ON m.np_scope = np."Scope"
        WHERE np."Resource" = 'NetworkPolicy'
    ) AS g
    WHERE NOT EXISTS (
        SELECT 1 FROM "CustomRolePermissions" p
        WHERE p."CustomRoleId" = g.role_id
          AND p."Resource"     = 'MeshPolicy'
          AND p."Scope"        = g.mesh_scope
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260911081954_MeshPolicyRbac') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260911081954_MeshPolicyRbac', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260911130524_AddMeshPolicyTamperDetector') THEN
    ALTER TABLE "ThreatIntelSettings" ADD COLUMN IF NOT EXISTS "MeshPolicyTamperEnabled" boolean NOT NULL DEFAULT true;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260911130524_AddMeshPolicyTamperDetector') THEN
    CREATE TABLE IF NOT EXISTS "MeshPolicyChanges" (
        "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
        "ClusterName" character varying(256) NOT NULL,
        "Kind" character varying(64) NOT NULL,
        "Namespace" character varying(256) NOT NULL,
        "Name" character varying(256) NOT NULL,
        "Verb" character varying(32) NOT NULL,
        "Actor" character varying(512) NOT NULL,
        "ActorGroups" text NULL,
        "ImpersonatedUser" character varying(512) NULL,
        "SourceIp" character varying(64) NULL,
        "UserAgent" character varying(1024) NULL,
        "AuditId" character varying(128) NULL,
        "Reason" text NULL,
        "RequestObject" jsonb NULL,
        "ResponseObject" jsonb NULL,
        "Action" character varying(32) NULL,
        "MeshWide" boolean NOT NULL,
        "Governed" boolean NOT NULL,
        "GovernanceReason" character varying(512) NULL,
        "Assessment" character varying(32) NOT NULL,
        "AssessmentDetail" text NULL,
        "Rule" character varying(64) NULL,
        "IncidentRaised" boolean NOT NULL,
        "At" timestamp with time zone NOT NULL,
        "RecordedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_MeshPolicyChanges" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260911130524_AddMeshPolicyTamperDetector') THEN
    CREATE INDEX IF NOT EXISTS "IX_MeshPolicyChanges_Cluster_At" ON "MeshPolicyChanges" ("ClusterName", "At");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260911130524_AddMeshPolicyTamperDetector') THEN
    CREATE INDEX IF NOT EXISTS "IX_MeshPolicyChanges_Object_At" ON "MeshPolicyChanges" ("ClusterName", "Kind", "Namespace", "Name", "At");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260911130524_AddMeshPolicyTamperDetector') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260911130524_AddMeshPolicyTamperDetector', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260911211928_MeshEvidencePacksAdded') THEN
    CREATE TABLE "MeshEvidencePacks" (
        "Id" uuid NOT NULL,
        "RequestedBy" character varying(512) NOT NULL,
        "Origin" character varying(32) NOT NULL,
        "ScopeClusters" text NOT NULL,
        "ScopeNamespaces" text NOT NULL,
        "CollectionId" uuid,
        "CollectionName" character varying(512),
        "WindowFromUtc" timestamp with time zone NOT NULL,
        "WindowToUtc" timestamp with time zone NOT NULL,
        "Sections" text NOT NULL,
        "Sha256" character varying(64) NOT NULL,
        "SizeBytes" bigint NOT NULL,
        "Content" bytea NOT NULL,
        "FileName" character varying(256) NOT NULL,
        "AcknowledgedUnknowns" boolean NOT NULL,
        "UnknownCount" integer NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_MeshEvidencePacks" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260911211928_MeshEvidencePacksAdded') THEN
    CREATE INDEX "IX_MeshEvidencePacks_Collection_CreatedAt" ON "MeshEvidencePacks" ("CollectionId", "CreatedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260911211928_MeshEvidencePacksAdded') THEN
    CREATE INDEX "IX_MeshEvidencePacks_CreatedAt" ON "MeshEvidencePacks" ("CreatedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260911211928_MeshEvidencePacksAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260911211928_MeshEvidencePacksAdded', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914121222_MeshPolicyWatchSource') THEN
    ALTER TABLE "MeshPolicyChanges" ADD "ActorAttribution" character varying(512);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914121222_MeshPolicyWatchSource') THEN
    ALTER TABLE "MeshPolicyChanges" ADD "Source" character varying(16) NOT NULL DEFAULT 'audit';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914121222_MeshPolicyWatchSource') THEN
    ALTER TABLE "MeshPolicyChanges" ADD "TransitionObserved" boolean NOT NULL DEFAULT TRUE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914121222_MeshPolicyWatchSource') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260914121222_MeshPolicyWatchSource', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914125921_MeshPolicyChangeTwoLaneMerge') THEN
    ALTER TABLE "MeshPolicyChanges" ADD "CorrelationNote" character varying(1024);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914125921_MeshPolicyChangeTwoLaneMerge') THEN
    ALTER TABLE "MeshPolicyChanges" ADD "IncidentId" uuid;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914125921_MeshPolicyChangeTwoLaneMerge') THEN
    ALTER TABLE "MeshPolicyChanges" ADD "SecondaryAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914125921_MeshPolicyChangeTwoLaneMerge') THEN
    ALTER TABLE "MeshPolicyChanges" ADD "SecondarySource" character varying(16);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914125921_MeshPolicyChangeTwoLaneMerge') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260914125921_MeshPolicyChangeTwoLaneMerge', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914133754_MeshPolicyChangeTime') THEN
    ALTER TABLE "MeshPolicyChanges" ADD "ChangedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914133754_MeshPolicyChangeTime') THEN
    ALTER TABLE "MeshPolicyChanges" ADD "ChangedAtSource" character varying(32) NOT NULL DEFAULT 'unknown';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914133754_MeshPolicyChangeTime') THEN
    ALTER TABLE "MeshPolicyChanges" ADD "ObservedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914133754_MeshPolicyChangeTime') THEN
    UPDATE "MeshPolicyChanges"
                         SET "ChangedAt" = "At", "ChangedAtSource" = 'audit-request'
                       WHERE "Source" = 'audit' AND "ChangedAt" IS NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914133754_MeshPolicyChangeTime') THEN
    UPDATE "MeshPolicyChanges"
                         SET "ObservedAt" = "At"
                       WHERE "Source" = 'watch' AND "ObservedAt" IS NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914133754_MeshPolicyChangeTime') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260914133754_MeshPolicyChangeTime', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914141359_KubeAuditFeedWatermark') THEN
    CREATE TABLE "KubeAuditFeedWatermarks" (
        "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
        "ClusterName" character varying(256) NOT NULL DEFAULT '',
        "LastEventAt" timestamp with time zone NOT NULL,
        "EventCount" bigint NOT NULL,
        "LastAbuseShapeAt" timestamp with time zone,
        "AbuseShapeCount" bigint NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_KubeAuditFeedWatermarks" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914141359_KubeAuditFeedWatermark') THEN
    CREATE UNIQUE INDEX "IX_KubeAuditFeedWatermarks_Cluster" ON "KubeAuditFeedWatermarks" ("ClusterName");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914141359_KubeAuditFeedWatermark') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260914141359_KubeAuditFeedWatermark', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914143202_RbacBindingWatch') THEN
    CREATE TABLE "RbacBindingChanges" (
        "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
        "ClusterName" character varying(256) NOT NULL,
        "Kind" character varying(64) NOT NULL,
        "Namespace" character varying(256) NOT NULL,
        "Name" character varying(256) NOT NULL,
        "Verb" character varying(32) NOT NULL,
        "Source" character varying(16) NOT NULL DEFAULT 'watch',
        "Actor" character varying(512) NOT NULL,
        "ActorAttribution" character varying(1024),
        "TransitionObserved" boolean NOT NULL DEFAULT TRUE,
        "IsBaselineSnapshot" boolean NOT NULL DEFAULT FALSE,
        "Evidence" character varying(32) NOT NULL,
        "EvidenceDetail" text,
        "SpecWriter" character varying(256),
        "RequestObject" jsonb,
        "ResponseObject" jsonb,
        "PreviousObject" jsonb,
        "RoleRef" character varying(512),
        "RolePower" character varying(32),
        "SubjectCount" integer,
        "OpenSubjects" text,
        "ClusterWide" boolean NOT NULL,
        "Governed" boolean NOT NULL,
        "GovernanceReason" character varying(512),
        "Assessment" character varying(32) NOT NULL,
        "AssessmentDetail" text,
        "Rule" character varying(64),
        "IncidentRaised" boolean NOT NULL,
        "IncidentId" uuid,
        "SecondarySource" character varying(16),
        "SecondaryAt" timestamp with time zone,
        "CorrelationNote" character varying(1024),
        "At" timestamp with time zone NOT NULL,
        "ChangedAt" timestamp with time zone,
        "ChangedAtSource" character varying(32) NOT NULL DEFAULT 'unknown',
        "ObservedAt" timestamp with time zone,
        "RecordedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_RbacBindingChanges" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914143202_RbacBindingWatch') THEN
    CREATE TABLE "RbacWatchLaneStates" (
        "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
        "ClusterName" character varying(256) NOT NULL,
        "Kind" character varying(64) NOT NULL,
        "State" character varying(32) NOT NULL,
        "Reason" character varying(2048),
        "At" timestamp with time zone NOT NULL,
        "RecordedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_RbacWatchLaneStates" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914143202_RbacBindingWatch') THEN
    CREATE INDEX "IX_RbacBindingChanges_Cluster_At" ON "RbacBindingChanges" ("ClusterName", "At");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914143202_RbacBindingWatch') THEN
    CREATE INDEX "IX_RbacBindingChanges_Object_At" ON "RbacBindingChanges" ("ClusterName", "Kind", "Namespace", "Name", "At");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914143202_RbacBindingWatch') THEN
    CREATE UNIQUE INDEX "UX_RbacWatchLaneStates_Cluster_Kind" ON "RbacWatchLaneStates" ("ClusterName", "Kind");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914143202_RbacBindingWatch') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260914143202_RbacBindingWatch', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914161341_ContainmentAttachmentWatch') THEN
    ALTER TABLE "ContainmentActions" ADD "AttachmentActor" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914161341_ContainmentAttachmentWatch') THEN
    ALTER TABLE "ContainmentActions" ADD "AttachmentCheckedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914161341_ContainmentAttachmentWatch') THEN
    ALTER TABLE "ContainmentActions" ADD "AttachmentDetail" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914161341_ContainmentAttachmentWatch') THEN
    ALTER TABLE "ContainmentActions" ADD "AttachmentState" character varying(16);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914161341_ContainmentAttachmentWatch') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260914161341_ContainmentAttachmentWatch', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914165605_MeshPolicyChangeLaneIndex') THEN
    CREATE INDEX "IX_MeshPolicyChanges_Cluster_Source_At" ON "MeshPolicyChanges" ("ClusterName", "Source", "At");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914165605_MeshPolicyChangeLaneIndex') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260914165605_MeshPolicyChangeLaneIndex', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914180210_MeshPolicyChangeArchive') THEN
    CREATE TABLE "MeshPolicyChangeArchive" (
        "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
        "SourceId" bigint NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Kind" character varying(64) NOT NULL,
        "Namespace" character varying(256) NOT NULL,
        "Name" character varying(256) NOT NULL,
        "Verb" character varying(32) NOT NULL,
        "Source" character varying(16) NOT NULL DEFAULT 'audit',
        "Actor" character varying(512) NOT NULL,
        "ActorAttribution" character varying(512),
        "ActorGroups" text,
        "ImpersonatedUser" character varying(512),
        "SourceIp" character varying(64),
        "UserAgent" character varying(1024),
        "AuditId" character varying(128),
        "Reason" text,
        "Action" character varying(32),
        "MeshWide" boolean NOT NULL,
        "Governed" boolean NOT NULL,
        "GovernanceReason" character varying(512),
        "Assessment" character varying(32) NOT NULL,
        "AssessmentDetail" text,
        "Rule" character varying(64),
        "IncidentRaised" boolean NOT NULL,
        "IncidentId" uuid,
        "TransitionObserved" boolean NOT NULL DEFAULT TRUE,
        "SecondarySource" character varying(16),
        "SecondaryAt" timestamp with time zone,
        "CorrelationNote" character varying(1024),
        "At" timestamp with time zone NOT NULL,
        "ChangedAt" timestamp with time zone,
        "ChangedAtSource" character varying(32) NOT NULL DEFAULT 'unknown',
        "ObservedAt" timestamp with time zone,
        "RecordedAt" timestamp with time zone NOT NULL,
        "RequestObject" jsonb,
        "ResponseObject" jsonb,
        "BodiesRetained" boolean NOT NULL DEFAULT FALSE,
        "ArchivedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_MeshPolicyChangeArchive" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914180210_MeshPolicyChangeArchive') THEN
    CREATE INDEX "IX_MeshPolicyChangeArchive_At" ON "MeshPolicyChangeArchive" ("At");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914180210_MeshPolicyChangeArchive') THEN
    CREATE INDEX "IX_MeshPolicyChangeArchive_Object_At" ON "MeshPolicyChangeArchive" ("ClusterName", "Kind", "Namespace", "Name", "At");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914180210_MeshPolicyChangeArchive') THEN
    CREATE UNIQUE INDEX "UX_MeshPolicyChangeArchive_SourceId" ON "MeshPolicyChangeArchive" ("SourceId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914180210_MeshPolicyChangeArchive') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260914180210_MeshPolicyChangeArchive', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914180457_DetectorLaneState') THEN
    CREATE TABLE "DetectorLaneStates" (
        "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
        "Detector" character varying(64) NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Lane" character varying(64) NOT NULL,
        "State" character varying(32) NOT NULL,
        "Reason" character varying(2048),
        "LastObservedAt" timestamp with time zone,
        "At" timestamp with time zone NOT NULL,
        "RecordedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_DetectorLaneStates" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914180457_DetectorLaneState') THEN
    CREATE UNIQUE INDEX "UX_DetectorLaneStates_Detector_Cluster_Lane" ON "DetectorLaneStates" ("Detector", "ClusterName", "Lane");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914180457_DetectorLaneState') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260914180457_DetectorLaneState', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914182024_MeshEvidencePackRegimes') THEN
    ALTER TABLE "MeshEvidencePacks" ADD "Regimes" text NOT NULL DEFAULT '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914182024_MeshEvidencePackRegimes') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260914182024_MeshEvidencePackRegimes', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    ALTER TABLE "MeshEvidencePacks" ADD "ChainHash" character varying(64);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    ALTER TABLE "MeshEvidencePacks" ADD "PreviousChainHash" character varying(64);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE TABLE "MeshDenyStorms" (
        "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
        "ClusterName" character varying(256) NOT NULL,
        "Namespace" character varying(256) NOT NULL,
        "DistinctIdentities" integer NOT NULL,
        "DistinctServices" integer NOT NULL,
        "WindowStartUtc" timestamp with time zone NOT NULL,
        "WindowEndUtc" timestamp with time zone NOT NULL,
        "Arbitration" character varying(32) NOT NULL,
        "Governed" boolean NOT NULL,
        "GovernanceReason" character varying(2048) NOT NULL,
        "ActorAttribution" character varying(1024),
        "LaneEvidence" character varying(2048) NOT NULL,
        "ExplainedByChangeId" bigint,
        "IncidentId" uuid,
        "RecordedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_MeshDenyStorms" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE TABLE "MeshExpectationFindings" (
        "Id" uuid NOT NULL,
        "ExpectationId" uuid NOT NULL,
        "Cluster" character varying(256) NOT NULL,
        "AssertionText" text NOT NULL,
        "PreviousAnswer" character varying(16) NOT NULL,
        "NewAnswer" character varying(16) NOT NULL,
        "PreviousReason" text,
        "NewReason" text NOT NULL,
        "ObservedAtUtc" timestamp with time zone NOT NULL,
        "PreviousAnsweredAtUtc" timestamp with time zone,
        "ObservedBy" character varying(512) NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_MeshExpectationFindings" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE TABLE "MeshExpectations" (
        "Id" uuid NOT NULL,
        "Cluster" character varying(256) NOT NULL,
        "SourcePrincipal" character varying(512),
        "SourceNamespace" character varying(253),
        "SourceWorkload" character varying(253),
        "DestinationNamespace" character varying(253) NOT NULL,
        "DestinationWorkload" character varying(253) NOT NULL,
        "Port" integer NOT NULL,
        "Expectation" character varying(16) NOT NULL,
        "SourceText" text NOT NULL,
        "Author" character varying(512) NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "LastAnswer" character varying(16),
        "LastAnswerReason" text,
        "LastAnsweredAtUtc" timestamp with time zone,
        "LastAnswerChangedAtUtc" timestamp with time zone,
        CONSTRAINT "PK_MeshExpectations" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE TABLE "MeshManifestFindings" (
        "Id" uuid NOT NULL,
        "RepositoryScanId" uuid NOT NULL,
        "ScanRepositoryId" uuid NOT NULL,
        "CheckId" character varying(64) NOT NULL,
        "Outcome" character varying(16) NOT NULL,
        "EnforcementPoint" character varying(16) NOT NULL,
        "ResourceKind" character varying(64) NOT NULL,
        "ResourceName" character varying(256) NOT NULL,
        "ResourceNamespace" character varying(256) NOT NULL,
        "Title" character varying(256) NOT NULL,
        "Detail" text NOT NULL,
        "EvidenceFile" character varying(1024),
        "EvidenceCommit" character varying(64),
        "CreatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_MeshManifestFindings" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_MeshManifestFindings_RepositoryScans_RepositoryScanId" FOREIGN KEY ("RepositoryScanId") REFERENCES "RepositoryScans" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE TABLE "MeshOpenUnknowns" (
        "Id" uuid NOT NULL,
        "Cluster" character varying(256) NOT NULL,
        "Section" character varying(64) NOT NULL,
        "Input" character varying(512) NOT NULL,
        "LastReason" text NOT NULL,
        "Blocking" boolean NOT NULL,
        "FirstSeenUtc" timestamp with time zone NOT NULL,
        "LastSeenUtc" timestamp with time zone NOT NULL,
        "LastSeenBy" character varying(512) NOT NULL,
        "ClosedAtUtc" timestamp with time zone,
        "ClosedBy" character varying(512),
        "Owner" character varying(512),
        "Justification" text,
        "ReviewByUtc" timestamp with time zone,
        "AcceptedAtUtc" timestamp with time zone,
        "AcceptedBy" character varying(512),
        "CreatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_MeshOpenUnknowns" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE TABLE "MeshPolicyAccessRequests" (
        "Id" uuid NOT NULL,
        "Reference" character varying(64) NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Namespace" character varying(256) NOT NULL,
        "Workload" character varying(256) NOT NULL,
        "PolicyRecordId" uuid NOT NULL,
        "PolicyName" character varying(256) NOT NULL,
        "PolicyContentHash" character varying(128) NOT NULL,
        "RequestedIdentityKind" character varying(32) NOT NULL,
        "RequestedIdentity" character varying(512) NOT NULL,
        "RequestedPorts" character varying(256) NOT NULL,
        "BusinessReason" character varying(512) NOT NULL,
        "ExpiresAtUtc" timestamp with time zone,
        "TicketKey" character varying(256),
        "GitRef" character varying(256),
        "RequestedBy" character varying(512) NOT NULL,
        "RequestedAtUtc" timestamp with time zone NOT NULL,
        "RoutedOwner" character varying(512) NOT NULL,
        "RoutedOwnerContact" character varying(512),
        "RoutedOwnerSource" character varying(64) NOT NULL,
        "RoutedOwnerDetail" text NOT NULL,
        "RoutedOwnerIsBlanket" boolean NOT NULL,
        "PreflightCandidateHash" character varying(128) NOT NULL,
        "PreflightRanAtUtc" timestamp with time zone NOT NULL,
        "PreflightOutcome" character varying(64) NOT NULL,
        "PreflightFlips" integer NOT NULL,
        "PreflightAllowToDeny" integer NOT NULL,
        "PreflightDenyToAllow" integer NOT NULL,
        "PreflightZeroFlipsConclusive" boolean NOT NULL,
        "PreflightObservedHits" bigint NOT NULL,
        "PreflightQualifications" text NOT NULL,
        "Qualifications" text NOT NULL,
        "Status" character varying(32) NOT NULL,
        "DecidedBy" character varying(512),
        "DecidedAtUtc" timestamp with time zone,
        "DecisionNote" character varying(2048),
        "StampedOnRecord" boolean NOT NULL,
        "StampedAtUtc" timestamp with time zone,
        "StampFailureReason" character varying(1024),
        "CreatedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_MeshPolicyAccessRequests" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE TABLE "MeshRecertificationAttestations" (
        "Id" uuid NOT NULL,
        "ScopeKey" character varying(1024) NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Namespace" character varying(256) NOT NULL,
        "PolicyName" character varying(256) NOT NULL,
        "SourceField" character varying(32) NOT NULL,
        "NamedValue" character varying(512) NOT NULL,
        "RuleIndexes" character varying(256) NOT NULL,
        "RoutedOwner" character varying(256) NOT NULL,
        "RoutedOwnerSource" character varying(64) NOT NULL,
        "RoutedOwnerDetail" character varying(1024) NOT NULL,
        "RoutedOwnerIsBlanket" boolean NOT NULL,
        "Decision" character varying(16) NOT NULL,
        "Note" character varying(1024),
        "AttestedBy" character varying(256) NOT NULL,
        "AttestedAtUtc" timestamp with time zone NOT NULL,
        "WindowFromUtc" timestamp with time zone NOT NULL,
        "WindowToUtc" timestamp with time zone NOT NULL,
        "WindowDays" integer NOT NULL,
        "DaysObserved" integer NOT NULL,
        "DaysInWindow" integer NOT NULL,
        "ObservedHits" bigint NOT NULL,
        "ObservedDays" integer NOT NULL,
        "ObservedLastSeenUtc" timestamp with time zone,
        "CreatedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_MeshRecertificationAttestations" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE INDEX "IX_MeshEvidencePacks_ChainHash" ON "MeshEvidencePacks" ("ChainHash");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE UNIQUE INDEX "UX_MeshEvidencePacks_PreviousChainHash" ON "MeshEvidencePacks" ("PreviousChainHash");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE INDEX "IX_MeshDenyStorms_Arbitration_WindowEnd" ON "MeshDenyStorms" ("Arbitration", "WindowEndUtc");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE INDEX "IX_MeshDenyStorms_Scope_WindowEnd" ON "MeshDenyStorms" ("ClusterName", "Namespace", "WindowEndUtc");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE INDEX "IX_MeshExpectationFindings_Cluster_Observed" ON "MeshExpectationFindings" ("Cluster", "ObservedAtUtc");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE INDEX "IX_MeshExpectationFindings_Expectation" ON "MeshExpectationFindings" ("ExpectationId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE INDEX "IX_MeshExpectations_Cluster" ON "MeshExpectations" ("Cluster");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE INDEX "IX_MeshManifestFindings_RepositoryScanId" ON "MeshManifestFindings" ("RepositoryScanId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE INDEX "IX_MeshManifestFindings_ScanRepositoryId_CreatedAt" ON "MeshManifestFindings" ("ScanRepositoryId", "CreatedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE INDEX "IX_MeshOpenUnknowns_Closed_Cluster" ON "MeshOpenUnknowns" ("ClosedAtUtc", "Cluster");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE INDEX "IX_MeshOpenUnknowns_Open_FirstSeen" ON "MeshOpenUnknowns" ("FirstSeenUtc") WHERE "ClosedAtUtc" IS NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE INDEX "IX_MeshOpenUnknowns_ReviewBy" ON "MeshOpenUnknowns" ("ReviewByUtc") WHERE "ClosedAtUtc" IS NULL AND "ReviewByUtc" IS NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE UNIQUE INDEX "UX_MeshOpenUnknowns_Key" ON "MeshOpenUnknowns" ("Cluster", "Section", "Input");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE INDEX "IX_MeshPolicyAccessRequests_Open" ON "MeshPolicyAccessRequests" ("ClusterName", "RequestedAtUtc") WHERE "Status" = 'pending';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE INDEX "IX_MeshPolicyAccessRequests_Record" ON "MeshPolicyAccessRequests" ("PolicyRecordId", "RequestedAtUtc");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE UNIQUE INDEX "UX_MeshPolicyAccessRequests_Reference" ON "MeshPolicyAccessRequests" ("Reference");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE INDEX "IX_MeshRecertificationAttestations_Cluster_Ns_AttestedAt" ON "MeshRecertificationAttestations" ("ClusterName", "Namespace", "AttestedAtUtc");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    CREATE INDEX "IX_MeshRecertificationAttestations_Cluster_Scope_AttestedAt" ON "MeshRecertificationAttestations" ("ClusterName", "ScopeKey", "AttestedAtUtc");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260914214307_MeshP2Register') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260914214307_MeshP2Register', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260916074546_MeshIngestTokenOnCluster') THEN
    ALTER TABLE "SetupThirdParties" ADD "MeshIngestTokenEncrypted" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260916074546_MeshIngestTokenOnCluster') THEN
    ALTER TABLE "SetupThirdParties" ADD "MeshIngestTokenMintedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260916074546_MeshIngestTokenOnCluster') THEN
    ALTER TABLE "SetupThirdParties" ADD "MeshSidecarMonitoringEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260916074546_MeshIngestTokenOnCluster') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260916074546_MeshIngestTokenOnCluster', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260916093459_MeshVerdictSiemStream') THEN
    ALTER TABLE "SiemSettings" ADD "ForwardMeshVerdictAllows" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260916093459_MeshVerdictSiemStream') THEN
    ALTER TABLE "SiemSettings" ADD "ForwardMeshVerdicts" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260916093459_MeshVerdictSiemStream') THEN
    ALTER TABLE "SiemSettings" ADD "MeshVerdictsDestinationId" uuid;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260916093459_MeshVerdictSiemStream') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260916093459_MeshVerdictSiemStream', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260922063331_ComplianceRegimeSelectionAndClauseOverrides') THEN
    ALTER TABLE "MeshEvidencePacks" ADD "ExcludedControls" text NOT NULL DEFAULT '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260922063331_ComplianceRegimeSelectionAndClauseOverrides') THEN
    ALTER TABLE "MeshEvidencePacks" ADD "LicensedEdition" integer NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260922063331_ComplianceRegimeSelectionAndClauseOverrides') THEN
    CREATE TABLE "RegulatoryClauseOverrides" (
        "Id" uuid NOT NULL,
        "ControlId" text NOT NULL,
        "Clause" text NOT NULL,
        "SuppliedBy" text NOT NULL,
        "SuppliedAtUtc" timestamp with time zone NOT NULL,
        "Note" text,
        CONSTRAINT "PK_RegulatoryClauseOverrides" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260922063331_ComplianceRegimeSelectionAndClauseOverrides') THEN
    CREATE TABLE "RegulatoryRegimeSelections" (
        "Id" uuid NOT NULL,
        "Regime" text NOT NULL,
        "SelectedBy" text NOT NULL,
        "SelectedAtUtc" timestamp with time zone NOT NULL,
        "RemovedAtUtc" timestamp with time zone,
        "RemovedBy" text,
        CONSTRAINT "PK_RegulatoryRegimeSelections" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260922063331_ComplianceRegimeSelectionAndClauseOverrides') THEN
    CREATE UNIQUE INDEX "IX_RegulatoryClauseOverrides_ControlId" ON "RegulatoryClauseOverrides" ("ControlId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260922063331_ComplianceRegimeSelectionAndClauseOverrides') THEN
    CREATE UNIQUE INDEX "IX_RegulatoryRegimeSelections_Regime" ON "RegulatoryRegimeSelections" ("Regime") WHERE "RemovedAtUtc" IS NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260922063331_ComplianceRegimeSelectionAndClauseOverrides') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260922063331_ComplianceRegimeSelectionAndClauseOverrides', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260928084925_AddMcpWriteGateSettings') THEN
    ALTER TABLE "AnalyticsSettings" ADD "AllowMcpContainmentActions" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260928084925_AddMcpWriteGateSettings') THEN
    CREATE TABLE "McpWriteGateSettings" (
        "Id" uuid NOT NULL,
        "AllowNetworkPolicyDeploy" boolean NOT NULL,
        "AllowManualNetworkPolicyApproval" boolean NOT NULL,
        "AllowKubernetesPush" boolean NOT NULL,
        "AllowIdentityReachContainment" boolean NOT NULL,
        "AllowGlobalWhitelistWrite" boolean NOT NULL,
        "AllowProtectedNamespaceWrite" boolean NOT NULL,
        CONSTRAINT "PK_McpWriteGateSettings" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260928084925_AddMcpWriteGateSettings') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260928084925_AddMcpWriteGateSettings', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260928120020_ObsAnalyticsAlertRuleOutcome') THEN
    ALTER TABLE "AnalyticsAlertRules" ADD "LastOutcome" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260928120020_ObsAnalyticsAlertRuleOutcome') THEN
    ALTER TABLE "AnalyticsAlertRules" ADD "LastOutcomeReason" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260928120020_ObsAnalyticsAlertRuleOutcome') THEN
    ALTER TABLE "AnalyticsAlertRules" ADD "LastValueComplete" boolean;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260928120020_ObsAnalyticsAlertRuleOutcome') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260928120020_ObsAnalyticsAlertRuleOutcome', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260928144245_SegAuthorRevertMergeTimesNullable') THEN
    ALTER TABLE "OldNetworkPolicyRecords" ALTER COLUMN "LastRevertedTime" DROP NOT NULL;
    ALTER TABLE "OldNetworkPolicyRecords" ALTER COLUMN "LastRevertedTime" DROP DEFAULT;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260928144245_SegAuthorRevertMergeTimesNullable') THEN
    ALTER TABLE "OldNetworkPolicyRecords" ALTER COLUMN "LastMergeTime" DROP NOT NULL;
    ALTER TABLE "OldNetworkPolicyRecords" ALTER COLUMN "LastMergeTime" DROP DEFAULT;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260928144245_SegAuthorRevertMergeTimesNullable') THEN
    ALTER TABLE "NetworkPolicyRecords" ALTER COLUMN "LastRevertedTime" DROP NOT NULL;
    ALTER TABLE "NetworkPolicyRecords" ALTER COLUMN "LastRevertedTime" DROP DEFAULT;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260928144245_SegAuthorRevertMergeTimesNullable') THEN
    ALTER TABLE "NetworkPolicyRecords" ALTER COLUMN "LastMergeTime" DROP NOT NULL;
    ALTER TABLE "NetworkPolicyRecords" ALTER COLUMN "LastMergeTime" DROP DEFAULT;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260928144245_SegAuthorRevertMergeTimesNullable') THEN
    UPDATE "NetworkPolicyRecords" SET "LastRevertedTime" = NULL WHERE COALESCE("RevertedBy", '') = '' AND "LastRevertedTime" IS NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260928144245_SegAuthorRevertMergeTimesNullable') THEN
    UPDATE "NetworkPolicyRecords" SET "LastMergeTime" = NULL WHERE COALESCE("MergedBy", '') = '' AND "LastMergeTime" IS NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260928144245_SegAuthorRevertMergeTimesNullable') THEN
    UPDATE "OldNetworkPolicyRecords" SET "LastRevertedTime" = NULL WHERE COALESCE("RevertedBy", '') = '' AND "LastRevertedTime" IS NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260928144245_SegAuthorRevertMergeTimesNullable') THEN
    UPDATE "OldNetworkPolicyRecords" SET "LastMergeTime" = NULL WHERE COALESCE("MergedBy", '') = '' AND "LastMergeTime" IS NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260928144245_SegAuthorRevertMergeTimesNullable') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260928144245_SegAuthorRevertMergeTimesNullable', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260930132232_AddRemainingMcpWriteGates') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowAuthzPolicyDelete" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260930132232_AddRemainingMcpWriteGates') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowAuthzPolicyDeploy" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260930132232_AddRemainingMcpWriteGates') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowAuthzPolicyManualApply" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260930132232_AddRemainingMcpWriteGates') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowAxeraFlowDeployment" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260930132232_AddRemainingMcpWriteGates') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowAxeraFlowUninstall" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260930132232_AddRemainingMcpWriteGates') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowBackupDelete" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260930132232_AddRemainingMcpWriteGates') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowBackupRestore" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260930132232_AddRemainingMcpWriteGates') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowCaptureDelete" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260930132232_AddRemainingMcpWriteGates') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowKubernetesNetworkPolicyProxyWrite" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260930132232_AddRemainingMcpWriteGates') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowMeshSidecarMonitoringWrite" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260930132232_AddRemainingMcpWriteGates') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowNetworkPolicyWatcherWrite" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260930132232_AddRemainingMcpWriteGates') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowPolicyVersionRollback" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260930132232_AddRemainingMcpWriteGates') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowProcessPolicyDelete" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260930132232_AddRemainingMcpWriteGates') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowProcessPolicyDeploy" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260930132232_AddRemainingMcpWriteGates') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260930132232_AddRemainingMcpWriteGates', '10.0.12');
    END IF;
END $EF$;
COMMIT;


START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261001134127_GitLayoutProfiles') THEN
    CREATE TABLE "GitLayoutProfiles" (
        "Id" uuid NOT NULL,
        "Name" character varying(200) NOT NULL,
        "Description" character varying(2000),
        "IsDefault" boolean NOT NULL,
        "Spec" jsonb NOT NULL,
        "Version" integer NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "CreatedBy" character varying(256),
        "UpdatedAt" timestamp with time zone,
        "UpdatedBy" character varying(256),
        CONSTRAINT "PK_GitLayoutProfiles" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261001134127_GitLayoutProfiles') THEN
    CREATE UNIQUE INDEX "IX_GitLayoutProfiles_IsDefault" ON "GitLayoutProfiles" ("IsDefault") WHERE "IsDefault" = true;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261001134127_GitLayoutProfiles') THEN
    CREATE UNIQUE INDEX "IX_GitLayoutProfiles_Name" ON "GitLayoutProfiles" ("Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261001134127_GitLayoutProfiles') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261001134127_GitLayoutProfiles', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "SetupThirdParties" ADD COLUMN IF NOT EXISTS "ExcessPrivileges" text[];
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "SetupThirdParties" ADD COLUMN IF NOT EXISTS "LastPrivilegeCheckAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "SetupThirdParties" ADD COLUMN IF NOT EXISTS "LastPrivilegeCheckError" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "ScanRepositories" ADD COLUMN IF NOT EXISTS "CredentialOwnerUserId" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "PolicyHitDaily" ADD COLUMN IF NOT EXISTS "AclCount" bigint NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "PolicyHitDaily" ADD COLUMN IF NOT EXISTS "FlowCount" bigint NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "OldNetworkPolicyRecords" ADD COLUMN IF NOT EXISTS "SavedBy" character varying(256) NOT NULL DEFAULT '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD COLUMN IF NOT EXISTS "AclHitCount" bigint NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD COLUMN IF NOT EXISTS "DeployedSpecHash" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD COLUMN IF NOT EXISTS "DeployedVersionNumber" integer;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD COLUMN IF NOT EXISTS "FlowHitCount" bigint NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD COLUMN IF NOT EXISTS "LiveDriftDetectedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD COLUMN IF NOT EXISTS "SavedBy" character varying(256) NOT NULL DEFAULT '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "MeshRecertificationAttestations" ADD COLUMN IF NOT EXISTS "EvidenceFromUtc" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "McpWriteGateSettings" ADD COLUMN IF NOT EXISTS "AllowAiSettingsWrite" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "McpWriteGateSettings" ADD COLUMN IF NOT EXISTS "AllowAnalyticsSettingsWrite" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "McpWriteGateSettings" ADD COLUMN IF NOT EXISTS "AllowBackupCreate" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "McpWriteGateSettings" ADD COLUMN IF NOT EXISTS "AllowBackupSettingsWrite" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "McpWriteGateSettings" ADD COLUMN IF NOT EXISTS "AllowCaptureCreate" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "McpWriteGateSettings" ADD COLUMN IF NOT EXISTS "AllowLicenseWrite" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "McpWriteGateSettings" ADD COLUMN IF NOT EXISTS "AllowLoggingReconfigure" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "McpWriteGateSettings" ADD COLUMN IF NOT EXISTS "AllowNetworkPolicyRecordMigration" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "LDAPConnections" ADD COLUMN IF NOT EXISTS "DisplayName" character varying(128);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "KubernetesPushCronResults" ALTER COLUMN "CreatedAt" SET DEFAULT (now());
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "GitProviderSettings" ALTER COLUMN "Shared" SET DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    CREATE TABLE IF NOT EXISTS "AnalyticsAlertFirings" (
        "Id" uuid NOT NULL,
        "RuleId" uuid NOT NULL,
        "RuleName" text NOT NULL,
        "ClusterId" text NOT NULL,
        "MetricKind" text NOT NULL,
        "Value" double precision NOT NULL,
        "Complete" boolean,
        "Severity" text NOT NULL,
        "Trigger" text NOT NULL,
        "FiredAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_AnalyticsAlertFirings" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    CREATE TABLE IF NOT EXISTS "PolicyRecommendationSnapshots" (
        "ClusterName" character varying(253) NOT NULL,
        "ReportJson" jsonb NOT NULL,
        "GeneratedAt" timestamp with time zone NOT NULL,
        "Model" text,
        "DurationMs" bigint,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_PolicyRecommendationSnapshots" PRIMARY KEY ("ClusterName")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    INSERT INTO "McpWriteGateSettings" ("Id", "AllowNetworkPolicyDeploy", "AllowManualNetworkPolicyApproval", "AllowKubernetesPush", "AllowIdentityReachContainment", "AllowGlobalWhitelistWrite", "AllowProtectedNamespaceWrite", "AllowBackupDelete", "AllowBackupRestore", "AllowAxeraFlowDeployment", "AllowAxeraFlowUninstall", "AllowKubernetesNetworkPolicyProxyWrite", "AllowCaptureDelete", "AllowNetworkPolicyWatcherWrite", "AllowMeshSidecarMonitoringWrite", "AllowAuthzPolicyDeploy", "AllowAuthzPolicyManualApply", "AllowAuthzPolicyDelete", "AllowPolicyVersionRollback", "AllowProcessPolicyDeploy", "AllowProcessPolicyDelete", "AllowCaptureCreate", "AllowBackupCreate", "AllowBackupSettingsWrite", "AllowLicenseWrite", "AllowAiSettingsWrite", "AllowLoggingReconfigure", "AllowAnalyticsSettingsWrite", "AllowNetworkPolicyRecordMigration")
    SELECT gen_random_uuid(), FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE
    WHERE NOT EXISTS (SELECT 1 FROM "McpWriteGateSettings");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "AnalyticsTrackedScopes"
    SET "ClusterName" = btrim("ClusterName"), "Namespace" = NULLIF(btrim("Namespace"), '')
    WHERE "ClusterName" <> btrim("ClusterName") OR "Namespace" IS DISTINCT FROM NULLIF(btrim("Namespace"), '');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    DELETE FROM "AnalyticsTrackedScopes" s
    USING (SELECT "Id", ROW_NUMBER() OVER (PARTITION BY "ClusterName", COALESCE("Namespace", '') ORDER BY "CreatedAt", "Id") AS rn
           FROM "AnalyticsTrackedScopes") d
    WHERE s."Id" = d."Id" AND d.rn > 1;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "NetworkPolicyRecords" r SET "HitCount" = d.s
    FROM (SELECT "PolicyRecordId", SUM("Count") AS s FROM "PolicyHitDaily" GROUP BY 1) d
    WHERE r."Id" = d."PolicyRecordId" AND r."HitCount" < d.s;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "AnalyticsAlertRules"
    SET "WindowMinutes" = CAST(GREATEST(5, CEIL("WindowMinutes" / 5.0) * 5) AS integer)
    WHERE "WindowMinutes" < 5 OR "WindowMinutes" % 5 <> 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "AnalyticsAlertRules" SET "Threshold" = "Threshold" / 100.0
    WHERE "MetricKind" = 'drop_rate' AND "Threshold" > 1 AND "Threshold" <= 100;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "AnalyticsAlertRules"
    SET "Enabled" = FALSE, "LastOutcome" = 'not-judged',
        "LastOutcomeReason" = 'disabled by the v13.3.0 upgrade: a drop_rate threshold above 100% is invalid'
    WHERE "MetricKind" = 'drop_rate' AND "Threshold" > 100;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "NetworkPolicyRecords" SET "NetworkPolicy" = jsonb_set("NetworkPolicy", '{ApiVersion}', '"networking.k8s.io/v1"')
    WHERE jsonb_typeof("NetworkPolicy") = 'object' AND COALESCE("NetworkPolicy"->>'ApiVersion', '') = '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "NetworkPolicyRecords" SET "NetworkPolicy" = jsonb_set("NetworkPolicy", '{Kind}', '"NetworkPolicy"')
    WHERE jsonb_typeof("NetworkPolicy") = 'object' AND COALESCE("NetworkPolicy"->>'Kind', '') = '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "OldNetworkPolicyRecords" SET "NetworkPolicy" = jsonb_set("NetworkPolicy", '{ApiVersion}', '"networking.k8s.io/v1"')
    WHERE jsonb_typeof("NetworkPolicy") = 'object' AND COALESCE("NetworkPolicy"->>'ApiVersion', '') = '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "OldNetworkPolicyRecords" SET "NetworkPolicy" = jsonb_set("NetworkPolicy", '{Kind}', '"NetworkPolicy"')
    WHERE jsonb_typeof("NetworkPolicy") = 'object' AND COALESCE("NetworkPolicy"->>'Kind', '') = '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "AnalyticsSettings"
    SET "AutoResponseMode" = CASE WHEN lower("AutoResponseMode") = 'enforce' THEN 'Enforce' ELSE 'Monitor' END
    WHERE "AutoResponseMode" IS DISTINCT FROM 'Monitor' AND "AutoResponseMode" IS DISTINCT FROM 'Enforce';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "AnalyticsSettings" ALTER COLUMN "AutoResponseMode" SET DEFAULT 'Monitor';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    WITH d AS (
        SELECT "Id", "OwnerUserId", "Name",
               ROW_NUMBER() OVER (PARTITION BY "OwnerUserId", "Name" ORDER BY "CreatedAt", "Id") AS rn
        FROM "AnalyticsSavedViews")
    UPDATE "AnalyticsSavedViews" v
    SET "Name" = CASE
            WHEN EXISTS (SELECT 1 FROM "AnalyticsSavedViews" o
                         WHERE o."OwnerUserId" = d."OwnerUserId" AND o."Name" = d."Name" || ' (' || d.rn || ')')
            THEN d."Name" || ' (' || d.rn || ', ' || left(v."Id"::text, 8) || ')'
            ELSE d."Name" || ' (' || d.rn || ')'
        END
    FROM d
    WHERE v."Id" = d."Id" AND d.rn > 1;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "NetworkPolicyRecords" SET "DeployedVersionNumber" = "VersionNumber"
    WHERE "DeploymentState" = 'Deployed' AND "DeployedVersionNumber" IS NULL
      AND ("LastDeployedAt" IS NULL OR "LastModifiedTime" <= "LastDeployedAt"
           OR ("RecoveredAt" IS NOT NULL AND "RecoveredAt" >= "LastDeployedAt"
               AND "LastModifiedTime" <= "RecoveredAt" + interval '1 second'));
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "NetworkPolicyRecords" r SET "DeployedVersionNumber" = s.v
    FROM (SELECT c."Id", MAX(o."VersionNumber") AS v
          FROM "NetworkPolicyRecords" c
          JOIN "OldNetworkPolicyRecords" o
            ON o."Name" = c."Name" AND o."ClusterName" = c."ClusterName" AND o."Namespace" = c."Namespace"
           AND o."VersionNumber" < c."VersionNumber" AND o."LastModifiedTime" <= c."LastDeployedAt"
          WHERE c."DeploymentState" = 'Deployed' AND c."DeployedVersionNumber" IS NULL
            AND c."LastModifiedTime" > c."LastDeployedAt"
          GROUP BY c."Id") s
    WHERE r."Id" = s."Id" AND r."DeployedVersionNumber" IS NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "ScanRepositories" r SET "CredentialOwnerUserId" = u."Id"
    FROM (SELECT DISTINCT ON (reg.repo_id) reg.repo_id, reg.actor
          FROM (SELECT lower(substring(e."Details" from '"Id"[[:space:]]*:[[:space:]]*"([0-9A-Fa-f-]{36})"')) AS repo_id,
                       regexp_replace(COALESCE(e."Actor", ''), ' \(via MCP agent\)$', '') AS actor,
                       e."At" AS at, e."Id" AS audit_id
                FROM "AuditEntries" e
                WHERE e."Action" = 'shiftLeft.repository.register') reg
          WHERE reg.repo_id IS NOT NULL
          ORDER BY reg.repo_id, reg.at, reg.audit_id) first_registration
    JOIN "AspNetUsers" u ON u."UserName" = first_registration.actor
    WHERE r."CredentialOwnerUserId" IS NULL AND r."Id"::text = first_registration.repo_id;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "NetworkPolicyRecords" SET "SavedBy" = "CreatedBy" WHERE "VersionNumber" = 1 AND "SavedBy" = '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "OldNetworkPolicyRecords" SET "SavedBy" = "CreatedBy" WHERE "VersionNumber" = 1 AND "SavedBy" = '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "KubernetesPushCronResults" SET "CreatedAt" = COALESCE("ScheduledAt", "UpdatedAt", now())
    WHERE "CreatedAt" = '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    DELETE FROM "KubernetesPushCronResults"
    WHERE "Status" = 0 AND "ScheduledAt" IS NULL AND "Immediate" = FALSE AND "JobId" = '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "WatcherSettings" SET "AddedEventAction" = 1 WHERE "AddedEventAction" NOT IN (1, 2, 3);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "WatcherSettings" SET "ModifiedEventAction" = 1 WHERE "ModifiedEventAction" NOT IN (1, 2, 3);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    UPDATE "WatcherSettings" SET "DeletedEventAction" = 1 WHERE "DeletedEventAction" NOT IN (1, 2, 3);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    DELETE FROM "CustomRolePermissions" WHERE "Resource" = 'Proxy';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    CREATE UNIQUE INDEX IF NOT EXISTS "UX_AnalyticsTrackedScopes_Cluster_Namespace"
    ON "AnalyticsTrackedScopes" ("ClusterName", COALESCE("Namespace", ''));
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'CK_WatcherSettings_AddedEventAction' AND conrelid = '"WatcherSettings"'::regclass) THEN
        ALTER TABLE "WatcherSettings" ADD CONSTRAINT "CK_WatcherSettings_AddedEventAction" CHECK ("AddedEventAction" IN (1, 2, 3));
    END IF;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'CK_WatcherSettings_DeletedEventAction' AND conrelid = '"WatcherSettings"'::regclass) THEN
        ALTER TABLE "WatcherSettings" ADD CONSTRAINT "CK_WatcherSettings_DeletedEventAction" CHECK ("DeletedEventAction" IN (1, 2, 3));
    END IF;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'CK_WatcherSettings_ModifiedEventAction' AND conrelid = '"WatcherSettings"'::regclass) THEN
        ALTER TABLE "WatcherSettings" ADD CONSTRAINT "CK_WatcherSettings_ModifiedEventAction" CHECK ("ModifiedEventAction" IN (1, 2, 3));
    END IF;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    CREATE UNIQUE INDEX IF NOT EXISTS "IX_AnalyticsSavedViews_OwnerUserId_Name" ON "AnalyticsSavedViews" ("OwnerUserId", "Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    CREATE INDEX IF NOT EXISTS "IX_AnalyticsAlertFirings_FiredAt" ON "AnalyticsAlertFirings" ("FiredAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261004085500_AxeraV1330AppSchema', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;
DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261005081941_AddPersonalAccessTokens') THEN
    CREATE TABLE IF NOT EXISTS "PersonalAccessTokens" (
        "Id" uuid NOT NULL,
        "UserId" text NOT NULL,
        "Name" character varying(100) NOT NULL,
        "TokenHint" character varying(16) NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "ExpiresAt" timestamp with time zone NOT NULL,
        "LastUsedAt" timestamp with time zone,
        "RevokedAt" timestamp with time zone,
        "RevokedBy" character varying(256),
        CONSTRAINT "PK_PersonalAccessTokens" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_PersonalAccessTokens_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261005081941_AddPersonalAccessTokens') THEN
    CREATE INDEX IF NOT EXISTS "IX_PersonalAccessTokens_UserId" ON "PersonalAccessTokens" ("UserId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261005081941_AddPersonalAccessTokens') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    SELECT gen_random_uuid(), r."Id", 'ApiToken', 'Write'
    FROM "CustomRoles" r
    WHERE NOT EXISTS (
        SELECT 1 FROM "CustomRolePermissions" p
        WHERE p."CustomRoleId" = r."Id"
          AND p."Resource"     = 'ApiToken'
          AND p."Scope"        = 'Write'
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261005081941_AddPersonalAccessTokens') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261005081941_AddPersonalAccessTokens', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261007110243_AddApiTokenScopesAndLastUsedAddress') THEN
    ALTER TABLE "PersonalAccessTokens" ADD COLUMN IF NOT EXISTS "LastUsedIp" character varying(64);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261007110243_AddApiTokenScopesAndLastUsedAddress') THEN
    ALTER TABLE "PersonalAccessTokens" ADD COLUMN IF NOT EXISTS "LastUsedUserAgent" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261007110243_AddApiTokenScopesAndLastUsedAddress') THEN
    ALTER TABLE "PersonalAccessTokens" ADD COLUMN IF NOT EXISTS "Scopes" character varying(8000);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261007110243_AddApiTokenScopesAndLastUsedAddress') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261007110243_AddApiTokenScopesAndLastUsedAddress', '10.0.12');
    END IF;
END $EF$;
COMMIT;
START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    ALTER TABLE "PersonalAccessTokens" ADD COLUMN IF NOT EXISTS "Audience" character varying(2000);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    ALTER TABLE "PersonalAccessTokens" ADD COLUMN IF NOT EXISTS "OAuthClientId" uuid;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    ALTER TABLE "PersonalAccessTokens" ADD COLUMN IF NOT EXISTS "PreviousRefreshTokenHash" character varying(64);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    ALTER TABLE "PersonalAccessTokens" ADD COLUMN IF NOT EXISTS "RefreshExpiresAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    ALTER TABLE "PersonalAccessTokens" ADD COLUMN IF NOT EXISTS "RefreshRotatedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    ALTER TABLE "PersonalAccessTokens" ADD COLUMN IF NOT EXISTS "RefreshTokenHash" character varying(64);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE TABLE IF NOT EXISTS "OAuthClients" (
        "Id" uuid NOT NULL,
        "ClientId" character varying(64) NOT NULL,
        "Name" character varying(100) NOT NULL,
        "Description" character varying(500),
        "SecretHash" character varying(64),
        "RedirectUris" character varying(4000) NOT NULL,
        "MaxScopes" character varying(8000),
        "AccessTokenLifetimeMinutes" integer NOT NULL,
        "RefreshTokenIdleDays" integer NOT NULL,
        "ConnectionLifetimeDays" integer NOT NULL,
        "IsDisabled" boolean NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "CreatedBy" character varying(256),
        "UpdatedAt" timestamp with time zone,
        CONSTRAINT "PK_OAuthClients" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE TABLE IF NOT EXISTS "OAuthAuthorizationCodes" (
        "Id" uuid NOT NULL,
        "CodeHash" character varying(64) NOT NULL,
        "OAuthClientId" uuid NOT NULL,
        "UserId" text NOT NULL,
        "RedirectUri" character varying(2000) NOT NULL,
        "CodeChallenge" character varying(128) NOT NULL,
        "Scopes" character varying(8000),
        "Resource" character varying(2000),
        "CreatedAt" timestamp with time zone NOT NULL,
        "ExpiresAt" timestamp with time zone NOT NULL,
        "ConsumedAt" timestamp with time zone,
        "ConnectionId" uuid,
        CONSTRAINT "PK_OAuthAuthorizationCodes" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_OAuthAuthorizationCodes_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE,
        CONSTRAINT "FK_OAuthAuthorizationCodes_OAuthClients_OAuthClientId" FOREIGN KEY ("OAuthClientId") REFERENCES "OAuthClients" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE INDEX IF NOT EXISTS "IX_PersonalAccessTokens_OAuthClientId" ON "PersonalAccessTokens" ("OAuthClientId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE INDEX IF NOT EXISTS "IX_PersonalAccessTokens_PreviousRefreshTokenHash" ON "PersonalAccessTokens" ("PreviousRefreshTokenHash");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE UNIQUE INDEX IF NOT EXISTS "IX_PersonalAccessTokens_RefreshTokenHash" ON "PersonalAccessTokens" ("RefreshTokenHash");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE UNIQUE INDEX IF NOT EXISTS "IX_OAuthAuthorizationCodes_CodeHash" ON "OAuthAuthorizationCodes" ("CodeHash");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE INDEX IF NOT EXISTS "IX_OAuthAuthorizationCodes_ExpiresAt" ON "OAuthAuthorizationCodes" ("ExpiresAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE INDEX IF NOT EXISTS "IX_OAuthAuthorizationCodes_OAuthClientId" ON "OAuthAuthorizationCodes" ("OAuthClientId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE INDEX IF NOT EXISTS "IX_OAuthAuthorizationCodes_UserId" ON "OAuthAuthorizationCodes" ("UserId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE UNIQUE INDEX IF NOT EXISTS "IX_OAuthClients_ClientId" ON "OAuthClients" ("ClientId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_PersonalAccessTokens_OAuthClients_OAuthClientId') THEN
    ALTER TABLE "PersonalAccessTokens" ADD CONSTRAINT "FK_PersonalAccessTokens_OAuthClients_OAuthClientId" FOREIGN KEY ("OAuthClientId") REFERENCES "OAuthClients" ("Id") ON DELETE CASCADE;
    END IF;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261008131628_AddOAuthClients', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261014230336_WidenThirdPartyCredentialColumns') THEN
    ALTER TABLE "SetupThirdParties" ALTER COLUMN "Token" TYPE character varying(8192);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261014230336_WidenThirdPartyCredentialColumns') THEN
    ALTER TABLE "SetupThirdParties" ALTER COLUMN "Password" TYPE character varying(4096);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261014230336_WidenThirdPartyCredentialColumns') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261014230336_WidenThirdPartyCredentialColumns', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE TABLE "SecurityFeedSources" (
        "Id" uuid NOT NULL,
        "Name" character varying(200) NOT NULL,
        "Vendor" character varying(32) NOT NULL,
        "Mode" character varying(16) NOT NULL,
        "ClusterName" character varying(256),
        "Origin" character varying(16) NOT NULL,
        "Enabled" boolean NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_SecurityFeedSources" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE TABLE "WorkloadFindings" (
        "Id" uuid NOT NULL,
        "IdentityHash" character varying(64) NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Namespace" character varying(256) NOT NULL,
        "Workload" character varying(256) NOT NULL,
        "WorkloadKind" character varying(64) NOT NULL,
        "Container" character varying(256) NOT NULL,
        "ImageDigest" character varying(80) NOT NULL,
        "ScanDigest" character varying(80),
        "ImageRef" character varying(1024),
        "VulnId" character varying(128) NOT NULL,
        "Aliases" character varying(1024),
        "PackageName" character varying(512) NOT NULL,
        "PackageVersion" character varying(256) NOT NULL,
        "PackageClass" character varying(16) NOT NULL,
        "PackageType" character varying(64),
        "PackagePurl" character varying(1024),
        "PackagePath" character varying(2048),
        "FixedVersion" character varying(256),
        "DistroFamily" character varying(16),
        "OsName" character varying(128),
        "Severity" character varying(16) NOT NULL,
        "Cvss" double precision,
        "Kev" boolean NOT NULL,
        "Exploitable" boolean,
        "Title" character varying(512),
        "PrimaryLink" character varying(1024),
        "Reachability" character varying(24) NOT NULL,
        "Granularity" character varying(24),
        "Confidence" character varying(16),
        "UnknownReason" character varying(64),
        "NotObservedDays" integer,
        "VerdictDetail" character varying(1024),
        "VerdictAlgorithmVersion" integer NOT NULL,
        "HintsTableVersion" character varying(32),
        "VerdictFingerprint" character varying(32),
        "ReachabilityAssessedAt" timestamp with time zone,
        "LastEvidenceAt" timestamp with time zone,
        "InteractiveSeen" boolean NOT NULL,
        "InUseByEntrypoint" boolean NOT NULL,
        "EvidenceCount" integer NOT NULL,
        "EvidenceOmitted" integer NOT NULL,
        "DigestRunning" boolean NOT NULL,
        "DigestRunningSince" timestamp with time zone,
        "DigestLastRunningAt" timestamp with time zone,
        "ImageMatchesRunning" boolean,
        "FirstReportedAt" timestamp with time zone NOT NULL,
        "LastReportedAt" timestamp with time zone NOT NULL,
        "StaleSince" timestamp with time zone,
        CONSTRAINT "PK_WorkloadFindings" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE TABLE "SecurityFeedLanes" (
        "Id" uuid NOT NULL,
        "SourceId" uuid NOT NULL,
        "Lane" character varying(16) NOT NULL,
        "Enabled" boolean NOT NULL,
        "IntervalMinutes" integer NOT NULL,
        "State" character varying(24) NOT NULL,
        "LastRunAt" timestamp with time zone,
        "LastSuccessAt" timestamp with time zone,
        "LastPullComplete" boolean NOT NULL,
        "LastError" character varying(2000),
        "ConsecutiveFailures" integer NOT NULL,
        "ItemsReceived" integer NOT NULL,
        "ItemsMapped" integer NOT NULL,
        "ItemsUnmapped" integer NOT NULL,
        "ItemsDropped" integer NOT NULL,
        "ReportsRead" integer NOT NULL,
        "LastPullId" uuid,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_SecurityFeedLanes" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_SecurityFeedLanes_SecurityFeedSources_SourceId" FOREIGN KEY ("SourceId") REFERENCES "SecurityFeedSources" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE TABLE "WorkloadFindingEvidence" (
        "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
        "FindingId" uuid NOT NULL,
        "Kind" character varying(32) NOT NULL,
        "Session" character varying(16) NOT NULL,
        "Binary" character varying(2048) NOT NULL,
        "Path" character varying(2048),
        "Detail" character varying(512),
        "Container" character varying(256) NOT NULL,
        "PodName" character varying(256),
        "NodeName" character varying(256),
        "ImageDigest" character varying(80) NOT NULL,
        "ContainerInit" boolean NOT NULL,
        "FirstSeenAt" timestamp with time zone NOT NULL,
        "LastSeenAt" timestamp with time zone NOT NULL,
        "HitCount" bigint NOT NULL,
        "Source" character varying(32) NOT NULL,
        "CopiedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_WorkloadFindingEvidence" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_WorkloadFindingEvidence_WorkloadFindings_FindingId" FOREIGN KEY ("FindingId") REFERENCES "WorkloadFindings" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE TABLE "WorkloadFindingSourceReports" (
        "Id" uuid NOT NULL,
        "FindingId" uuid NOT NULL,
        "SourceId" uuid NOT NULL,
        "VendorRecordId" character varying(512),
        "VendorSeverity" character varying(32) NOT NULL,
        "NormalizedSeverity" character varying(16) NOT NULL,
        "VendorScore" double precision,
        "VendorPackageName" character varying(512) NOT NULL,
        "VendorPath" character varying(2048),
        "VendorScannedAt" timestamp with time zone,
        "VendorUrl" character varying(1024),
        "VendorInUse" boolean,
        "VendorInUseKey" character varying(128),
        "VendorState" character varying(64),
        "FirstReportedAt" timestamp with time zone NOT NULL,
        "LastReportedAt" timestamp with time zone NOT NULL,
        "LastPullId" uuid NOT NULL,
        CONSTRAINT "PK_WorkloadFindingSourceReports" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_WorkloadFindingSourceReports_SecurityFeedSources_SourceId" FOREIGN KEY ("SourceId") REFERENCES "SecurityFeedSources" ("Id") ON DELETE CASCADE,
        CONSTRAINT "FK_WorkloadFindingSourceReports_WorkloadFindings_FindingId" FOREIGN KEY ("FindingId") REFERENCES "WorkloadFindings" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE UNIQUE INDEX "IX_SecurityFeedLanes_Source_Lane" ON "SecurityFeedLanes" ("SourceId", "Lane");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE UNIQUE INDEX "IX_SecurityFeedSources_Name" ON "SecurityFeedSources" ("Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE INDEX "IX_SecurityFeedSources_Vendor_Cluster" ON "SecurityFeedSources" ("Vendor", "ClusterName");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE INDEX "IX_WorkloadFindingEvidence_Finding_LastSeen" ON "WorkloadFindingEvidence" ("FindingId", "LastSeenAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE INDEX "IX_WorkloadFindings_Cluster_Reachability" ON "WorkloadFindings" ("ClusterName", "Reachability");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE INDEX "IX_WorkloadFindings_Digest" ON "WorkloadFindings" ("ClusterName", "ImageDigest");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE INDEX "IX_WorkloadFindings_DigestRunning" ON "WorkloadFindings" ("DigestRunning", "DigestLastRunningAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE UNIQUE INDEX "IX_WorkloadFindings_IdentityHash" ON "WorkloadFindings" ("IdentityHash");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE INDEX "IX_WorkloadFindings_StaleSince" ON "WorkloadFindings" ("StaleSince");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE INDEX "IX_WorkloadFindings_Workload" ON "WorkloadFindings" ("ClusterName", "Namespace", "Workload");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE UNIQUE INDEX "IX_WorkloadFindingSourceReports_Finding_Source" ON "WorkloadFindingSourceReports" ("FindingId", "SourceId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    CREATE INDEX "IX_WorkloadFindingSourceReports_Source_Pull" ON "WorkloadFindingSourceReports" ("SourceId", "LastPullId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015051303_AddWorkloadFindings') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261015051303_AddWorkloadFindings', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015053303_IncidentStoryPhase0') THEN
    ALTER TABLE "Incidents" ADD "ClientIdentity" character varying(32);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015053303_IncidentStoryPhase0') THEN
    ALTER TABLE "Incidents" ADD "ClientKey" character varying(64);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015053303_IncidentStoryPhase0') THEN
    ALTER TABLE "Incidents" ADD "EntryRef" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015053303_IncidentStoryPhase0') THEN
    ALTER TABLE "Incidents" ADD "SrcIp" character varying(64);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015053303_IncidentStoryPhase0') THEN
    ALTER TABLE "IncidentEvents" ADD "Kind" character varying(32) NOT NULL DEFAULT 'detection';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015053303_IncidentStoryPhase0') THEN
    CREATE INDEX "IX_Incidents_Cluster_Dst_LastSeen" ON "Incidents" ("ClusterName", "DstNamespace", "DstWorkload", "LastSeenAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015053303_IncidentStoryPhase0') THEN
    CREATE INDEX "IX_Incidents_Cluster_DstHost_LastSeen" ON "Incidents" ("ClusterName", "DstHost", "LastSeenAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015053303_IncidentStoryPhase0') THEN
    CREATE INDEX "IX_Incidents_Cluster_DstIp_LastSeen" ON "Incidents" ("ClusterName", "DstIp", "LastSeenAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015053303_IncidentStoryPhase0') THEN
    CREATE INDEX "IX_Incidents_Cluster_Src_LastSeen" ON "Incidents" ("ClusterName", "SrcNamespace", "SrcWorkload", "LastSeenAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015053303_IncidentStoryPhase0') THEN
    CREATE INDEX "IX_IncidentEvents_Incident_Kind_At" ON "IncidentEvents" ("IncidentId", "Kind", "At");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015053303_IncidentStoryPhase0') THEN
    UPDATE "IncidentEvents" SET "Kind" = 'containment-attachment' WHERE "Payload" LIKE '{"kind":"containment-attachment"%';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015053303_IncidentStoryPhase0') THEN
    UPDATE "IncidentEvents" SET "Kind" = 'correction' WHERE "Payload" LIKE '{"correction":%';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015053303_IncidentStoryPhase0') THEN
    UPDATE "Incidents" i SET "EventCount" = GREATEST(1, i."EventCount" - c.n)
      FROM (SELECT "IncidentId", count(*)::int AS n FROM "IncidentEvents" WHERE "Kind" = 'correction' GROUP BY "IncidentId") c
      WHERE i."Id" = c."IncidentId" AND i."Detector" = 'mesh-policy-tamper';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015053303_IncidentStoryPhase0') THEN
    UPDATE "Incidents" SET "ClientKey" = substring("Title" from '^New external source ([^ ]+) reached ')
      WHERE "Detector" = 'ingress-first-contact' AND "ClientKey" IS NULL
        AND char_length(substring("Title" from '^New external source ([^ ]+) reached ')) <= 64;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015053303_IncidentStoryPhase0') THEN
    UPDATE "Incidents" SET "SrcIp" = "ClientKey"
      WHERE "Detector" = 'ingress-first-contact' AND "SrcIp" IS NULL AND "ClientKey" IS NOT NULL AND position('/' in "ClientKey") = 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015053303_IncidentStoryPhase0') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261015053303_IncidentStoryPhase0', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015081846_IncidentDisposition') THEN
    ALTER TABLE "Incidents" ADD "Disposition" integer;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015081846_IncidentDisposition') THEN
    ALTER TABLE "Incidents" ADD "DispositionAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015081846_IncidentDisposition') THEN
    ALTER TABLE "Incidents" ADD "DispositionBy" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015081846_IncidentDisposition') THEN
    UPDATE "Incidents" SET "Disposition" = 2, "DispositionAt" = COALESCE("DismissedAt", "UpdatedAt"), "DispositionBy" = 'migration: closed as FalsePositive' WHERE "Status" = 3 AND "Disposition" IS NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261015081846_IncidentDisposition') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261015081846_IncidentDisposition', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016164002_IncidentStoryFrames') THEN
    ALTER TABLE "Incidents" ADD "StoryLegalHold" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016164002_IncidentStoryFrames') THEN
    ALTER TABLE "Incidents" ADD "StoryLegalHoldAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016164002_IncidentStoryFrames') THEN
    ALTER TABLE "Incidents" ADD "StoryLegalHoldBy" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016164002_IncidentStoryFrames') THEN
    CREATE TABLE "IncidentStoryFrameSchedules" (
        "Id" uuid NOT NULL,
        "IncidentId" uuid NOT NULL,
        "Frame" character varying(32) NOT NULL,
        "DueAtUtc" timestamp with time zone NOT NULL,
        "CreatedAtUtc" timestamp with time zone NOT NULL,
        "UpdatedAtUtc" timestamp with time zone NOT NULL,
        "HangfireJobId" character varying(64),
        "State" character varying(16) NOT NULL,
        "RequestedBy" character varying(256),
        "Note" character varying(256),
        CONSTRAINT "PK_IncidentStoryFrameSchedules" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_IncidentStoryFrameSchedules_Incidents_IncidentId" FOREIGN KEY ("IncidentId") REFERENCES "Incidents" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016164002_IncidentStoryFrames') THEN
    CREATE TABLE "IncidentStorySnapshots" (
        "Id" uuid NOT NULL,
        "IncidentId" uuid NOT NULL,
        "ScheduleId" uuid,
        "Frame" character varying(32) NOT NULL,
        "TakenAtUtc" timestamp with time zone NOT NULL,
        "ScheduledForUtc" timestamp with time zone,
        "WindowFromUtc" timestamp with time zone NOT NULL,
        "WindowToUtc" timestamp with time zone NOT NULL,
        "AnchorUtc" timestamp with time zone NOT NULL,
        "ClampNote" text,
        "Status" character varying(16) NOT NULL,
        "Reason" character varying(256),
        "SchemaVersion" integer NOT NULL,
        "CollectorVersion" character varying(32),
        "PodIpGeneration" bigint,
        "Actor" character varying(256) NOT NULL,
        "Payload" text,
        "Coverage" jsonb,
        "RedactionClientAddresses" jsonb,
        "ContentHash" character varying(64),
        "Bytes" integer NOT NULL,
        CONSTRAINT "PK_IncidentStorySnapshots" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_IncidentStorySnapshots_Incidents_IncidentId" FOREIGN KEY ("IncidentId") REFERENCES "Incidents" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016164002_IncidentStoryFrames') THEN
    CREATE INDEX "IX_IncidentStoryFrameSchedules_Created" ON "IncidentStoryFrameSchedules" ("CreatedAtUtc");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016164002_IncidentStoryFrames') THEN
    CREATE INDEX "IX_IncidentStoryFrameSchedules_Incident_State" ON "IncidentStoryFrameSchedules" ("IncidentId", "State");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016164002_IncidentStoryFrames') THEN
    CREATE INDEX "IX_IncidentStoryFrameSchedules_State_Due" ON "IncidentStoryFrameSchedules" ("State", "DueAtUtc");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016164002_IncidentStoryFrames') THEN
    CREATE INDEX "IX_IncidentStorySnapshots_Incident_Taken" ON "IncidentStorySnapshots" ("IncidentId", "TakenAtUtc");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016164002_IncidentStoryFrames') THEN
    CREATE UNIQUE INDEX "IX_IncidentStorySnapshots_Schedule" ON "IncidentStorySnapshots" ("ScheduleId") WHERE "ScheduleId" IS NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016164002_IncidentStoryFrames') THEN
    CREATE INDEX "IX_IncidentStorySnapshots_Taken" ON "IncidentStorySnapshots" ("TakenAtUtc");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016164002_IncidentStoryFrames') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261016164002_IncidentStoryFrames', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016181606_WorkloadFindingsClusterIdIndex') THEN
    DROP INDEX "IX_WorkloadFindings_DigestRunning";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016181606_WorkloadFindingsClusterIdIndex') THEN
    CREATE INDEX "IX_WorkloadFindings_Cluster_Id" ON "WorkloadFindings" ("ClusterName", "Id");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016181606_WorkloadFindingsClusterIdIndex') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261016181606_WorkloadFindingsClusterIdIndex', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "WorkloadFindingSourceReports" ADD "VendorCvss" double precision;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "WorkloadFindingSourceReports" ADD "VendorExploitable" boolean;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "WorkloadFindingSourceReports" ADD "VendorKev" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "WorkloadFindingSourceReports" ADD "VendorStateDetail" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "WorkloadFindingSourceReports" ADD "VendorStateUntil" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "WorkloadFindings" ADD "Suppression" character varying(16);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "WorkloadFindings" ADD "SuppressionLabel" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "WorkloadFindings" ADD "SuppressionUntil" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "AllowInsecureTls" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "AuthKind" character varying(24);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "BaseUrl" character varying(1024);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "CaCertPem" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "ClientCertPem" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "ClientKeyPem" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "CreatedBy" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "CredentialCopiedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "DeletingSince" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "DisabledAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "InboundTokenHash" character varying(64);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "InboundTokenMintedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "LastTestAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "LastTestMessage" character varying(512);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "LastTestOk" boolean;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "LegacyCredentialClearedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "LinkedSetupThirdPartyId" uuid;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "Project" character varying(128);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "ProxyPassword" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "ProxyUrl" character varying(1024);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "ProxyUserName" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "Secret" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "TokenUrl" character varying(1024);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "TrustLevel" character varying(16) NOT NULL DEFAULT 'CorroborateOnly';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "UpdatedBy" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "UserName" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedSources" ADD "VendorOptionsJson" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedLanes" ADD "CircuitOpenUntil" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedLanes" ADD "CircuitOpenedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedLanes" ADD "CircuitState" character varying(16) NOT NULL DEFAULT 'closed';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedLanes" ADD "DiscoveryJson" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedLanes" ADD "DroppedJson" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedLanes" ADD "LastDurationMs" integer;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedLanes" ADD "LastPartialReason" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedLanes" ADD "LastStatusCode" integer;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedLanes" ADD "LastTrigger" character varying(16);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedLanes" ADD "LeaseUntil" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedLanes" ADD "NextRunAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedLanes" ADD "UnmappedJson" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    ALTER TABLE "SecurityFeedLanes" ADD "Watermark" character varying(1024);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    CREATE TABLE "SecurityFeedClusterMaps" (
        "Id" uuid NOT NULL,
        "SourceId" uuid NOT NULL,
        "VendorClusterKey" character varying(256) NOT NULL,
        "VendorClusterName" character varying(256),
        "AxeraClusterName" character varying(256),
        "Confirmed" boolean NOT NULL,
        "Proposed" boolean NOT NULL,
        "ConfirmedAt" timestamp with time zone,
        "ConfirmedBy" character varying(256),
        "FirstSeenAt" timestamp with time zone NOT NULL,
        "LastSeenAt" timestamp with time zone,
        CONSTRAINT "PK_SecurityFeedClusterMaps" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_SecurityFeedClusterMaps_SecurityFeedSources_SourceId" FOREIGN KEY ("SourceId") REFERENCES "SecurityFeedSources" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    CREATE TABLE "SecurityFeedExternalRefs" (
        "Id" uuid NOT NULL,
        "SourceId" uuid NOT NULL,
        "Kind" character varying(24) NOT NULL,
        "ExternalId" character varying(512) NOT NULL,
        "ExternalUrl" character varying(1024),
        "VendorState" character varying(64),
        "Label" character varying(256),
        "VendorFirstSeenAt" timestamp with time zone,
        "VendorLastSeenAt" timestamp with time zone,
        "Occurrences" integer NOT NULL,
        "IncidentId" uuid,
        "FirstSeenAt" timestamp with time zone NOT NULL,
        "LastSeenAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_SecurityFeedExternalRefs" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_SecurityFeedExternalRefs_Incidents_IncidentId" FOREIGN KEY ("IncidentId") REFERENCES "Incidents" ("Id") ON DELETE SET NULL,
        CONSTRAINT "FK_SecurityFeedExternalRefs_SecurityFeedSources_SourceId" FOREIGN KEY ("SourceId") REFERENCES "SecurityFeedSources" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    CREATE TABLE "SecurityFeedRawSamples" (
        "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
        "LaneId" uuid NOT NULL,
        "CapturedAt" timestamp with time zone NOT NULL,
        "Kind" character varying(64) NOT NULL,
        "Endpoint" character varying(512) NOT NULL,
        "Reason" character varying(64),
        "Truncated" boolean NOT NULL,
        "OriginalBytes" integer NOT NULL,
        "Body" text NOT NULL,
        CONSTRAINT "PK_SecurityFeedRawSamples" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_SecurityFeedRawSamples_SecurityFeedLanes_LaneId" FOREIGN KEY ("LaneId") REFERENCES "SecurityFeedLanes" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    CREATE TABLE "VendorProcessSightings" (
        "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
        "SourceId" uuid NOT NULL,
        "KeyHash" character varying(64) NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Namespace" character varying(256) NOT NULL,
        "Workload" character varying(256) NOT NULL,
        "WorkloadKind" character varying(64) NOT NULL,
        "Container" character varying(256) NOT NULL,
        "ImageDigest" character varying(80) NOT NULL,
        "ExecPath" character varying(2048) NOT NULL,
        "ProcessName" character varying(256) NOT NULL,
        "FirstSeenAt" timestamp with time zone NOT NULL,
        "LastSeenAt" timestamp with time zone NOT NULL,
        "ExecCount" bigint NOT NULL,
        "LastPullId" uuid NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_VendorProcessSightings" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_VendorProcessSightings_SecurityFeedSources_SourceId" FOREIGN KEY ("SourceId") REFERENCES "SecurityFeedSources" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    CREATE TABLE "VulnerabilityOverrides" (
        "Id" uuid NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Namespace" character varying(256) NOT NULL,
        "Workload" character varying(256) NOT NULL,
        "VulnId" character varying(128) NOT NULL,
        "PackageName" character varying(512) NOT NULL,
        "Status" character varying(16) NOT NULL,
        "Note" character varying(2000),
        "ExpiresAt" timestamp with time zone,
        "CreatedAt" timestamp with time zone NOT NULL,
        "CreatedBy" character varying(256),
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" character varying(256),
        CONSTRAINT "PK_VulnerabilityOverrides" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    CREATE INDEX "IX_SecurityFeedSources_LinkedSetupThirdPartyId" ON "SecurityFeedSources" ("LinkedSetupThirdPartyId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    CREATE INDEX "IX_SecurityFeedLanes_Due" ON "SecurityFeedLanes" ("Enabled", "NextRunAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    CREATE INDEX "IX_SecurityFeedClusterMaps_Axera" ON "SecurityFeedClusterMaps" ("AxeraClusterName");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    CREATE UNIQUE INDEX "IX_SecurityFeedClusterMaps_Source_Key" ON "SecurityFeedClusterMaps" ("SourceId", "VendorClusterKey");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    CREATE INDEX "IX_SecurityFeedExternalRefs_Incident" ON "SecurityFeedExternalRefs" ("IncidentId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    CREATE UNIQUE INDEX "IX_SecurityFeedExternalRefs_Key" ON "SecurityFeedExternalRefs" ("SourceId", "Kind", "ExternalId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    CREATE INDEX "IX_SecurityFeedExternalRefs_LastSeen" ON "SecurityFeedExternalRefs" ("LastSeenAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    CREATE INDEX "IX_SecurityFeedRawSamples_Lane_Captured" ON "SecurityFeedRawSamples" ("LaneId", "CapturedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    CREATE INDEX "IX_VendorProcessSightings_Container" ON "VendorProcessSightings" ("ClusterName", "Namespace", "Workload", "Container");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    CREATE UNIQUE INDEX "IX_VendorProcessSightings_Source_Key" ON "VendorProcessSightings" ("SourceId", "KeyHash");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    CREATE UNIQUE INDEX "IX_VulnerabilityOverrides_Key" ON "VulnerabilityOverrides" ("ClusterName", "Namespace", "Workload", "VulnId", "PackageName");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    SELECT gen_random_uuid(), g.role_id, 'SecurityFeed', 'Read'
    FROM (VALUES
        ('00000002-0000-0000-0000-000000000002'::uuid),
        ('00000003-0000-0000-0000-000000000003'::uuid)
    ) AS g(role_id)
    WHERE EXISTS (SELECT 1 FROM "CustomRoles" r WHERE r."Id" = g.role_id)
      AND NOT EXISTS (
        SELECT 1 FROM "CustomRolePermissions" p
        WHERE p."CustomRoleId" = g.role_id AND p."Resource" = 'SecurityFeed' AND p."Scope" = 'Read'
      );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016193514_AddSecurityFeedFramework') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261016193514_AddSecurityFeedFramework', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016204410_KubeAuditFeedHeartbeat') THEN
    ALTER TABLE "KubeAuditFeedWatermarks" ADD COLUMN IF NOT EXISTS "LastHeartbeatAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016204410_KubeAuditFeedHeartbeat') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261016204410_KubeAuditFeedHeartbeat', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016230555_IncidentEventClientColumns') THEN
    ALTER TABLE "IncidentEvents" ADD "ClientKey" character varying(64);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016230555_IncidentEventClientColumns') THEN
    ALTER TABLE "IncidentEvents" ADD "EntryRef" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016230555_IncidentEventClientColumns') THEN
    CREATE INDEX "IX_IncidentEvents_ClientKey_Incident" ON "IncidentEvents" ("ClientKey", "IncidentId") WHERE "ClientKey" IS NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016230555_IncidentEventClientColumns') THEN
    CREATE INDEX "IX_IncidentEvents_EntryRef_Incident" ON "IncidentEvents" ("EntryRef", "IncidentId") WHERE "EntryRef" IS NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016230555_IncidentEventClientColumns') THEN
    UPDATE "IncidentEvents" SET "ClientKey" = btrim(substring("Payload" from '"clientKey":"([^"\\]+)"'))
      WHERE "ClientKey" IS NULL AND "Kind" = 'detection' AND "Payload" LIKE '%"clientKey":"%'
        AND char_length(btrim(substring("Payload" from '"clientKey":"([^"\\]+)"'))) BETWEEN 1 AND 64;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016230555_IncidentEventClientColumns') THEN
    UPDATE "IncidentEvents" SET "EntryRef" = btrim(substring("Payload" from '"entryRef":"([^"\\]+)"'))
      WHERE "EntryRef" IS NULL AND "Kind" = 'detection' AND "Payload" LIKE '%"entryRef":"%'
        AND char_length(btrim(substring("Payload" from '"entryRef":"([^"\\]+)"'))) BETWEEN 1 AND 256;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261016230555_IncidentEventClientColumns') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261016230555_IncidentEventClientColumns', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SiemSettings" ADD "ForwardVendorIncidents" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedSources" ADD "DefaultClusterName" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedSources" ADD "InboundAuthHeader" character varying(64);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedSources" ADD "InboundEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedSources" ADD "InboundFormat" character varying(24);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedSources" ADD "InboundHmacSecret" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedSources" ADD "InboundHmacSecretSetAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedSources" ADD "InboundKey" character varying(32);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedSources" ADD "InboundPreviousTokenExpiresAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedSources" ADD "InboundPreviousTokenHash" character varying(64);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedSources" ADD "InboundTestReceivedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedLanes" ADD "LastReceivedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedLanes" ADD "RefusalsJson" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "Actor" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "ClusterName" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "ContainerName" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "DetailClearedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "DetailJson" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "Family" character varying(32);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "Namespace" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "NodeName" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "ObjectRef" character varying(512);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "Origin" character varying(8);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "PodName" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "ProcessPath" character varying(2048);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "Relation" character varying(16);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "Rule" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "RuleClass" character varying(32);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "RuleId" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "Score" integer;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "VendorSeverity" character varying(64);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "SecurityFeedExternalRefs" ADD "Workload" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    ALTER TABLE "Incidents" ADD "VendorContainable" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    CREATE TABLE "IncidentCorroborations" (
        "Id" uuid NOT NULL,
        "IncidentId" uuid NOT NULL,
        "Kind" character varying(24) NOT NULL,
        "SourceId" uuid,
        "Vendor" character varying(32),
        "VendorAlertId" character varying(512),
        "VendorUrl" character varying(1024),
        "Rule" character varying(256),
        "RuleClass" character varying(32) NOT NULL,
        "VendorSeverity" character varying(64),
        "CorroboratingIncidentId" uuid,
        "OtherDetector" character varying(64),
        "MatchedOn" character varying(32) NOT NULL,
        "MapVersion" integer NOT NULL,
        "Why" character varying(512) NOT NULL,
        "Detail" character varying(1024),
        "VendorAt" timestamp with time zone NOT NULL,
        "FirstLinkedAt" timestamp with time zone NOT NULL,
        "LastLinkedAt" timestamp with time zone NOT NULL,
        "Occurrences" integer NOT NULL,
        "DedupKey" character varying(64) NOT NULL,
        CONSTRAINT "PK_IncidentCorroborations" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_IncidentCorroborations_Incidents_CorroboratingIncidentId" FOREIGN KEY ("CorroboratingIncidentId") REFERENCES "Incidents" ("Id") ON DELETE SET NULL,
        CONSTRAINT "FK_IncidentCorroborations_Incidents_IncidentId" FOREIGN KEY ("IncidentId") REFERENCES "Incidents" ("Id") ON DELETE CASCADE,
        CONSTRAINT "FK_IncidentCorroborations_SecurityFeedSources_SourceId" FOREIGN KEY ("SourceId") REFERENCES "SecurityFeedSources" ("Id") ON DELETE SET NULL
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    CREATE UNIQUE INDEX "IX_SecurityFeedSources_InboundKey" ON "SecurityFeedSources" ("InboundKey") WHERE "InboundKey" IS NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    CREATE INDEX "IX_SecurityFeedExternalRefs_AlertSubject" ON "SecurityFeedExternalRefs" ("Kind", "ClusterName", "VendorLastSeenAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    CREATE UNIQUE INDEX "IX_IncidentCorroborations_DedupKey" ON "IncidentCorroborations" ("DedupKey");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    CREATE INDEX "IX_IncidentCorroborations_Incident" ON "IncidentCorroborations" ("IncidentId", "LastLinkedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    CREATE INDEX "IX_IncidentCorroborations_Other" ON "IncidentCorroborations" ("CorroboratingIncidentId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    CREATE INDEX "IX_IncidentCorroborations_Source" ON "IncidentCorroborations" ("SourceId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017143655_AddVendorAlertIncidents') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261017143655_AddVendorAlertIncidents', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017174851_AddImageSboms') THEN
    ALTER TABLE "WorkloadFindings" ADD "OwnershipSource" character varying(16);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017174851_AddImageSboms') THEN
    ALTER TABLE "WorkloadFindings" ADD "SbomId" uuid;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017174851_AddImageSboms') THEN
    CREATE TABLE "ImageSboms" (
        "Id" uuid NOT NULL,
        "ImageDigest" character varying(80) NOT NULL,
        "DigestVerified" boolean NOT NULL,
        "SbomDigests" character varying(1024),
        "Format" character varying(32) NOT NULL,
        "SchemaVersion" character varying(32),
        "ToolName" character varying(64),
        "ToolVersion" character varying(64),
        "SourceName" character varying(512),
        "DistroId" character varying(32),
        "DistroVersion" character varying(64),
        "PackageCount" integer NOT NULL,
        "OsPackageCount" integer NOT NULL,
        "OsPackagesWithFiles" integer NOT NULL,
        "FileCount" integer NOT NULL,
        "StoredFileCount" integer NOT NULL,
        "DocumentSha256" character varying(64) NOT NULL,
        "SizeBytes" bigint NOT NULL,
        "UploadedBy" character varying(256) NOT NULL,
        "UploadedAt" timestamp with time zone NOT NULL,
        "Note" character varying(512),
        CONSTRAINT "PK_ImageSboms" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017174851_AddImageSboms') THEN
    CREATE TABLE "ImageSbomPackages" (
        "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
        "SbomId" uuid NOT NULL,
        "Name" character varying(512) NOT NULL,
        "Version" character varying(256) NOT NULL,
        "Epoch" character varying(16),
        "Type" character varying(16) NOT NULL,
        "Purl" character varying(1024),
        "SourcePackage" character varying(512),
        "Arch" character varying(32),
        "FilesListed" boolean NOT NULL,
        "FileCount" integer NOT NULL,
        "LoadableFileCount" integer NOT NULL,
        CONSTRAINT "PK_ImageSbomPackages" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_ImageSbomPackages_ImageSboms_SbomId" FOREIGN KEY ("SbomId") REFERENCES "ImageSboms" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017174851_AddImageSboms') THEN
    CREATE TABLE "ImageSbomFiles" (
        "Id" bigint GENERATED BY DEFAULT AS IDENTITY,
        "PackageId" bigint NOT NULL,
        "SbomId" uuid NOT NULL,
        "Path" character varying(1024) NOT NULL,
        "Kind" character varying(16) NOT NULL,
        CONSTRAINT "PK_ImageSbomFiles" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_ImageSbomFiles_ImageSbomPackages_PackageId" FOREIGN KEY ("PackageId") REFERENCES "ImageSbomPackages" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017174851_AddImageSboms') THEN
    CREATE INDEX "IX_ImageSbomFiles_Package" ON "ImageSbomFiles" ("PackageId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017174851_AddImageSboms') THEN
    CREATE INDEX "IX_ImageSbomFiles_Sbom_Path" ON "ImageSbomFiles" ("SbomId", "Path");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017174851_AddImageSboms') THEN
    CREATE INDEX "IX_ImageSbomPackages_Sbom_Name" ON "ImageSbomPackages" ("SbomId", "Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017174851_AddImageSboms') THEN
    CREATE UNIQUE INDEX "IX_ImageSboms_ImageDigest" ON "ImageSboms" ("ImageDigest");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017174851_AddImageSboms') THEN
    CREATE INDEX "IX_ImageSboms_UploadedAt" ON "ImageSboms" ("UploadedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017174851_AddImageSboms') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261017174851_AddImageSboms', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017214423_SbomPlatformAndExecutables') THEN
    ALTER TABLE "ImageSboms" ADD "Architecture" character varying(32);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017214423_SbomPlatformAndExecutables') THEN
    ALTER TABLE "ImageSboms" ADD "Os" character varying(32);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017214423_SbomPlatformAndExecutables') THEN
    ALTER TABLE "ImageSboms" ADD "OsPackagesExecutablesInferred" integer NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017214423_SbomPlatformAndExecutables') THEN
    ALTER TABLE "ImageSbomPackages" ADD "ExecutablesKnown" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017214423_SbomPlatformAndExecutables') THEN
    ALTER TABLE "ImageSbomPackages" ADD "UntrackedModuleFileCount" integer NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017214423_SbomPlatformAndExecutables') THEN
    UPDATE "ImageSbomPackages" SET "ExecutablesKnown" = TRUE WHERE "Type" IN ('rpm', 'apk');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017214423_SbomPlatformAndExecutables') THEN
    UPDATE "ImageSboms" AS s SET "OsPackagesExecutablesInferred" = (SELECT count(*)::int FROM "ImageSbomPackages" AS p WHERE p."SbomId" = s."Id" AND p."FilesListed" AND NOT p."ExecutablesKnown");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017214423_SbomPlatformAndExecutables') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261017214423_SbomPlatformAndExecutables', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017215355_CountedAlertSweepIndexes') THEN
    CREATE INDEX "IX_SecurityFeedExternalRefs_CountedAlerts_ReceiptTime" ON "SecurityFeedExternalRefs" ("LastSeenAt") WHERE "Kind" = 'alert' AND "Relation" = 'counted' AND "VendorLastSeenAt" IS NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017215355_CountedAlertSweepIndexes') THEN
    CREATE INDEX "IX_SecurityFeedExternalRefs_CountedAlerts_VendorTime" ON "SecurityFeedExternalRefs" ("VendorLastSeenAt") WHERE "Kind" = 'alert' AND "Relation" = 'counted';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261017215355_CountedAlertSweepIndexes') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261017215355_CountedAlertSweepIndexes', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261018120821_VendorRetentionIndexes') THEN
    CREATE INDEX "IX_Incidents_Vendor" ON "Incidents" ("Id") WHERE "Detector" IN ('vendor-runtime-alert', 'vendor-control-plane-alert');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261018120821_VendorRetentionIndexes') THEN
    CREATE INDEX "IX_IncidentEvents_VendorMarker_Unstubbed" ON "IncidentEvents" ("At", "Id") WHERE "Kind" = 'vendor-corroboration' AND "Payload" IS NOT NULL AND "Payload" NOT LIKE '%"retained":false}';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261018120821_VendorRetentionIndexes') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261018120821_VendorRetentionIndexes', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261018150211_SbomPlatformDigestVerification') THEN
    ALTER TABLE "ImageSboms" ADD "DigestVerifiedByPlatform" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261018150211_SbomPlatformDigestVerification') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261018150211_SbomPlatformDigestVerification', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261018182614_AddVulnerableInUseExposedToggle') THEN
    ALTER TABLE "ThreatIntelSettings" ADD "VulnerableInUseExposedEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261018182614_AddVulnerableInUseExposedToggle') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261018182614_AddVulnerableInUseExposedToggle', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261018191110_AddKevCatalog') THEN
    ALTER TABLE "WorkloadFindings" ADD "KevCatalogVersion" character varying(32);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261018191110_AddKevCatalog') THEN
    ALTER TABLE "WorkloadFindings" ADD "KevListedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261018191110_AddKevCatalog') THEN
    CREATE TABLE "KevCatalogEntries" (
        "CveId" character varying(32) NOT NULL,
        "VendorProject" character varying(256) NOT NULL,
        "Product" character varying(256) NOT NULL,
        "VulnerabilityName" character varying(512) NOT NULL,
        "DateAdded" timestamp with time zone NOT NULL,
        "DueDate" timestamp with time zone,
        "KnownRansomwareCampaignUse" character varying(16) NOT NULL,
        "ShortDescription" character varying(1024) NOT NULL,
        "Cwes" character varying(256),
        "ImportId" uuid NOT NULL,
        CONSTRAINT "PK_KevCatalogEntries" PRIMARY KEY ("CveId")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261018191110_AddKevCatalog') THEN
    CREATE TABLE "KevCatalogImports" (
        "Id" uuid NOT NULL,
        "CatalogVersion" character varying(32) NOT NULL,
        "DateReleased" timestamp with time zone,
        "Declared" integer NOT NULL,
        "Entries" integer NOT NULL,
        "Skipped" integer NOT NULL,
        "Source" character varying(16) NOT NULL,
        "SourceDetail" character varying(512),
        "Sha256" character varying(64) NOT NULL,
        "Status" character varying(16) NOT NULL,
        "Message" character varying(1000),
        "Active" boolean NOT NULL,
        "ImportedAt" timestamp with time zone NOT NULL,
        "ImportedBy" character varying(256),
        CONSTRAINT "PK_KevCatalogImports" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261018191110_AddKevCatalog') THEN
    CREATE INDEX "IX_KevCatalogImports_Active" ON "KevCatalogImports" ("Active");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261018191110_AddKevCatalog') THEN
    CREATE INDEX "IX_KevCatalogImports_ImportedAt" ON "KevCatalogImports" ("ImportedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261018191110_AddKevCatalog') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261018191110_AddKevCatalog', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261019060822_AddSecurityFeedSyncMcpGate') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowSecurityFeedSync" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261019060822_AddSecurityFeedSyncMcpGate') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261019060822_AddSecurityFeedSyncMcpGate', '10.0.12');
    END IF;
END $EF$;
COMMIT;
START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020124104_AddSigmaRules') THEN
    ALTER TABLE "ThreatIntelSettings" ADD "SigmaRulesEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020124104_AddSigmaRules') THEN
    CREATE TABLE "SigmaRuleMatches" (
        "Id" uuid NOT NULL,
        "RuleId" uuid NOT NULL,
        "RuleName" character varying(128) NOT NULL,
        "GroupKey" character varying(1024) NOT NULL,
        "ClusterName" character varying(256),
        "Namespace" character varying(256),
        "Workload" character varying(256),
        "NodeName" character varying(256),
        "GroupJson" text,
        "Detail" text,
        "Level" character varying(16) NOT NULL,
        "MaxIncidentSeverity" character varying(16) NOT NULL,
        "IncidentIds" text NOT NULL,
        "IncidentCount" integer NOT NULL,
        "Fingerprint" character varying(32) NOT NULL,
        "FirstSeenAt" timestamp with time zone NOT NULL,
        "LastSeenAt" timestamp with time zone NOT NULL,
        "FirstMatchedAt" timestamp with time zone NOT NULL,
        "LastMatchedAt" timestamp with time zone NOT NULL,
        "LastEmittedAt" timestamp with time zone,
        "IncidentId" uuid,
        "Suppressed" boolean NOT NULL,
        CONSTRAINT "PK_SigmaRuleMatches" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020124104_AddSigmaRules') THEN
    CREATE TABLE "SigmaRuleRevisions" (
        "Id" uuid NOT NULL,
        "RuleId" uuid NOT NULL,
        "Version" integer NOT NULL,
        "Yaml" text NOT NULL,
        "Change" character varying(16) NOT NULL,
        "ChangedAt" timestamp with time zone NOT NULL,
        "ChangedBy" character varying(256),
        CONSTRAINT "PK_SigmaRuleRevisions" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020124104_AddSigmaRules') THEN
    CREATE TABLE "SigmaRules" (
        "Id" uuid NOT NULL,
        "Name" character varying(128) NOT NULL,
        "SigmaId" character varying(128),
        "Title" character varying(512) NOT NULL,
        "Description" text,
        "Level" character varying(16) NOT NULL,
        "RuleStatus" character varying(32),
        "Kind" character varying(32) NOT NULL,
        "Yaml" text NOT NULL,
        "Tags" text,
        "Techniques" character varying(1024),
        "Detectors" character varying(2048),
        "Author" character varying(256),
        "Enabled" boolean NOT NULL,
        "Builtin" boolean NOT NULL,
        "BuiltinKey" character varying(128),
        "BuiltinVersion" integer NOT NULL,
        "BuiltinModified" boolean NOT NULL,
        "Version" integer NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "CreatedBy" character varying(256),
        "UpdatedAt" timestamp with time zone NOT NULL,
        "UpdatedBy" character varying(256),
        "LastEvaluatedAt" timestamp with time zone,
        "LastMatchAt" timestamp with time zone,
        "LastError" text,
        CONSTRAINT "PK_SigmaRules" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020124104_AddSigmaRules') THEN
    CREATE TABLE "SigmaSuppressions" (
        "Id" uuid NOT NULL,
        "RuleId" uuid,
        "Cluster" character varying(256),
        "Namespace" character varying(256),
        "Workload" character varying(256),
        "Reason" character varying(1024) NOT NULL,
        "ExpiresAt" timestamp with time zone,
        "CreatedAt" timestamp with time zone NOT NULL,
        "CreatedBy" character varying(256),
        CONSTRAINT "PK_SigmaSuppressions" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020124104_AddSigmaRules') THEN
    CREATE INDEX "IX_SigmaRuleMatches_LastMatchedAt" ON "SigmaRuleMatches" ("LastMatchedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020124104_AddSigmaRules') THEN
    CREATE UNIQUE INDEX "IX_SigmaRuleMatches_RuleId_GroupKey" ON "SigmaRuleMatches" ("RuleId", "GroupKey");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020124104_AddSigmaRules') THEN
    CREATE INDEX "IX_SigmaRuleRevisions_RuleId_Version" ON "SigmaRuleRevisions" ("RuleId", "Version");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020124104_AddSigmaRules') THEN
    CREATE INDEX "IX_SigmaRules_BuiltinKey" ON "SigmaRules" ("BuiltinKey");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020124104_AddSigmaRules') THEN
    CREATE INDEX "IX_SigmaRules_Enabled" ON "SigmaRules" ("Enabled");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020124104_AddSigmaRules') THEN
    CREATE UNIQUE INDEX "IX_SigmaRules_Name" ON "SigmaRules" ("Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020124104_AddSigmaRules') THEN
    CREATE INDEX "IX_SigmaSuppressions_RuleId" ON "SigmaSuppressions" ("RuleId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020124104_AddSigmaRules') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261020124104_AddSigmaRules', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261024111801_AddThreatIntelFeedLastSizeBytes') THEN
    ALTER TABLE "ThreatIntelFeeds" ADD "LastSizeBytes" bigint;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261024111801_AddThreatIntelFeedLastSizeBytes') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261024111801_AddThreatIntelFeedLastSizeBytes', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261024120221_AddThreatContext') THEN
    ALTER TABLE "ThreatIntelSettings" ADD "OrganizationIndustry" character varying(32);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261024120221_AddThreatContext') THEN
    ALTER TABLE "ThreatIntelSettings" ADD "ThreatContextEnabled" boolean NOT NULL DEFAULT TRUE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261024120221_AddThreatContext') THEN
    ALTER TABLE "ThreatIntelSettings" ADD "ThreatContextInWebhooks" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261024120221_AddThreatContext') THEN
    CREATE TABLE "ThreatGroupCatalogImports" (
        "Id" uuid NOT NULL,
        "DatasetId" character varying(96) NOT NULL,
        "AttackVersion" character varying(16) NOT NULL,
        "AttackModified" date,
        "Curation" character varying(16) NOT NULL,
        "Profiles" integer NOT NULL,
        "Campaigns" integer NOT NULL,
        "Source" character varying(16) NOT NULL,
        "SourceDetail" character varying(512),
        "Sha256" character varying(64) NOT NULL,
        "Status" character varying(16) NOT NULL,
        "Message" character varying(1000),
        "Active" boolean NOT NULL,
        "Content" text,
        "ImportedAt" timestamp with time zone NOT NULL,
        "ImportedBy" character varying(256),
        CONSTRAINT "PK_ThreatGroupCatalogImports" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261024120221_AddThreatContext') THEN
    CREATE INDEX "IX_ThreatGroupCatalogImports_ImportedAt" ON "ThreatGroupCatalogImports" ("ImportedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261024120221_AddThreatContext') THEN
    CREATE UNIQUE INDEX "UX_ThreatGroupCatalogImports_Active" ON "ThreatGroupCatalogImports" ("Active") WHERE "Active";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261024120221_AddThreatContext') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261024120221_AddThreatContext', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261025114907_HotPathRbacBindingChangesIndex') THEN
    SET LOCAL lock_timeout = '5s';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261025114907_HotPathRbacBindingChangesIndex') THEN
    CREATE INDEX "IX_RbacBindingChanges_ClusterName_Source_At" ON "RbacBindingChanges" ("ClusterName", "Source", "At");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261025114907_HotPathRbacBindingChangesIndex') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261025114907_HotPathRbacBindingChangesIndex', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261025114908_HotPathPolicyHitDailyHotUpdates') THEN
    SET LOCAL lock_timeout = '5s';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261025114908_HotPathPolicyHitDailyHotUpdates') THEN
    ALTER TABLE "PolicyHitDaily" SET (autovacuum_analyze_scale_factor='0.02', autovacuum_vacuum_scale_factor='0.05', fillfactor='80');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261025114908_HotPathPolicyHitDailyHotUpdates') THEN
    CREATE INDEX "IX_PolicyHitDaily_Siem_Pending" ON "PolicyHitDaily" ("Day") WHERE "ForwardedAt" IS NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261025114908_HotPathPolicyHitDailyHotUpdates') THEN
    DROP INDEX IF EXISTS "IX_PolicyHitDaily_ForwardedAt_UpdatedAt";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261025114908_HotPathPolicyHitDailyHotUpdates') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261025114908_HotPathPolicyHitDailyHotUpdates', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261025174031_KubeAuditFeedGapHistogram') THEN
    SET LOCAL lock_timeout = '5s';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261025174031_KubeAuditFeedGapHistogram') THEN
    ALTER TABLE "KubeAuditFeedWatermarks" ADD "GapHistogram" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261025174031_KubeAuditFeedGapHistogram') THEN
    ALTER TABLE "KubeAuditFeedWatermarks" ADD "GapHistogramPrevious" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261025174031_KubeAuditFeedGapHistogram') THEN
    ALTER TABLE "KubeAuditFeedWatermarks" ADD "GapWindowStartedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261025174031_KubeAuditFeedGapHistogram') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261025174031_KubeAuditFeedGapHistogram', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261025183951_HotPathRbacSecondarySightingIndex') THEN
    SET LOCAL lock_timeout = '5s';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261025183951_HotPathRbacSecondarySightingIndex') THEN
    CREATE INDEX "IX_RbacBindingChanges_Cluster_Secondary_At" ON "RbacBindingChanges" ("ClusterName", "SecondarySource", "SecondaryAt") WHERE "SecondarySource" IS NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261025183951_HotPathRbacSecondarySightingIndex') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261025183951_HotPathRbacSecondarySightingIndex', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261029090126_SigmaRulesAsCode') THEN
    ALTER TABLE "SigmaSuppressions" ADD "Managed" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261029090126_SigmaRulesAsCode') THEN
    ALTER TABLE "SigmaSuppressions" ADD "ManagedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261029090126_SigmaRulesAsCode') THEN
    ALTER TABLE "SigmaSuppressions" ADD "ManagedSource" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261029090126_SigmaRulesAsCode') THEN
    ALTER TABLE "SigmaRules" ADD "Managed" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261029090126_SigmaRulesAsCode') THEN
    ALTER TABLE "SigmaRules" ADD "ManagedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261029090126_SigmaRulesAsCode') THEN
    ALTER TABLE "SigmaRules" ADD "ManagedPath" character varying(512);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261029090126_SigmaRulesAsCode') THEN
    ALTER TABLE "SigmaRules" ADD "ManagedSource" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261029090126_SigmaRulesAsCode') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261029090126_SigmaRulesAsCode', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261030095536_KerberosIntegration') THEN
    CREATE TABLE "KerberosIntegrations" (
        "Id" uuid NOT NULL,
        "DisplayName" character varying(128) NOT NULL,
        "Realm" character varying(255) NOT NULL,
        "ServicePrincipalName" character varying(512) NOT NULL,
        "LdapConnectionId" uuid,
        "AutoSignIn" boolean NOT NULL,
        "IsEnabled" boolean NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_KerberosIntegrations" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_KerberosIntegrations_LDAPConnections_LdapConnectionId" FOREIGN KEY ("LdapConnectionId") REFERENCES "LDAPConnections" ("Id") ON DELETE SET NULL
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261030095536_KerberosIntegration') THEN
    CREATE INDEX "IX_KerberosIntegrations_LdapConnectionId" ON "KerberosIntegrations" ("LdapConnectionId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261030095536_KerberosIntegration') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261030095536_KerberosIntegration', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261030130123_AddAdminPolicyRecords') THEN
    CREATE TABLE "AdminPolicyRecords" (
        "Id" uuid NOT NULL,
        "ClusterName" character varying(200) NOT NULL,
        "Kind" character varying(64) NOT NULL,
        "Name" character varying(253) NOT NULL,
        "Manifest" jsonb NOT NULL,
        "Priority" integer,
        "ApiVersion" character varying(128),
        "VersionNumber" integer NOT NULL,
        "CreatedBy" character varying(200) NOT NULL,
        "Created" timestamp with time zone NOT NULL DEFAULT (now()),
        "SavedBy" character varying(256) NOT NULL DEFAULT '',
        "RevertedBy" character varying(200) NOT NULL DEFAULT '',
        "LastRevertedTime" timestamp with time zone,
        "LastModifiedTime" timestamp with time zone NOT NULL DEFAULT (now()),
        "LastHitTime" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity',
        "DeploymentState" character varying(32) NOT NULL DEFAULT 'Draft',
        "LastDeployedAt" timestamp with time zone,
        "DeployedVersionNumber" integer,
        "DeployedSpecHash" text,
        "DeployedObjectUid" character varying(64),
        "LiveDriftDetectedAt" timestamp with time zone,
        "LiveMissingDetectedAt" timestamp with time zone,
        "LiveMissingReason" character varying(32),
        "DeletedAt" timestamp with time zone,
        "RecoveredAt" timestamp with time zone,
        "LastModifiedBy" text,
        "LastModifiedByGroups" text,
        "LastModifiedVia" text,
        "LastModifiedAudit" text,
        "LastAttributedAt" timestamp with time zone,
        CONSTRAINT "PK_AdminPolicyRecords" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261030130123_AddAdminPolicyRecords') THEN
    CREATE TABLE "BlockedAddresses" (
        "Id" uuid NOT NULL,
        "ClusterName" character varying(200) NOT NULL,
        "Cidr" character varying(64) NOT NULL,
        "Direction" character varying(16) NOT NULL,
        "Ports" text[] NOT NULL,
        "ScopeKind" character varying(32) NOT NULL,
        "ScopeNamespaces" text[] NOT NULL,
        "ScopeWorkload" character varying(512),
        "ScopeText" character varying(1024) NOT NULL DEFAULT '',
        "Reason" character varying(1024),
        "CreatedBy" character varying(256) NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL DEFAULT (now()),
        "LiftedAt" timestamp with time zone,
        "LiftedBy" character varying(256),
        CONSTRAINT "PK_BlockedAddresses" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261030130123_AddAdminPolicyRecords') THEN
    CREATE TABLE "OldAdminPolicyRecords" (
        "Id" uuid NOT NULL,
        "RecordId" uuid NOT NULL,
        "ClusterName" character varying(200) NOT NULL,
        "Kind" character varying(64) NOT NULL,
        "Name" character varying(253) NOT NULL,
        "VersionNumber" integer NOT NULL DEFAULT 1,
        "Manifest" jsonb NOT NULL,
        "Priority" integer,
        "ApiVersion" character varying(128),
        "CreatedBy" character varying(200) NOT NULL,
        "Created" timestamp with time zone NOT NULL DEFAULT (now()),
        "SavedBy" character varying(256) NOT NULL DEFAULT '',
        "Via" character varying(64),
        "LastModifiedTime" timestamp with time zone NOT NULL DEFAULT (now()),
        CONSTRAINT "PK_OldAdminPolicyRecords" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_OldAdminPolicyRecords_AdminPolicyRecords_RecordId" FOREIGN KEY ("RecordId") REFERENCES "AdminPolicyRecords" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261030130123_AddAdminPolicyRecords') THEN
    CREATE UNIQUE INDEX "IX_AdminPolicyRecords_Cluster_Kind_Name" ON "AdminPolicyRecords" ("ClusterName", "Kind", "Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261030130123_AddAdminPolicyRecords') THEN
    CREATE INDEX "IX_BlockedAddresses_Cluster_LiftedAt" ON "BlockedAddresses" ("ClusterName", "LiftedAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261030130123_AddAdminPolicyRecords') THEN
    CREATE UNIQUE INDEX "IX_OldAdminPolicyRecords_Cluster_Kind_Name_Version" ON "OldAdminPolicyRecords" ("ClusterName", "Kind", "Name", "VersionNumber");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261030130123_AddAdminPolicyRecords') THEN
    CREATE INDEX "IX_OldAdminPolicyRecords_RecordId" ON "OldAdminPolicyRecords" ("RecordId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261030130123_AddAdminPolicyRecords') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261030130123_AddAdminPolicyRecords', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261030130208_OverridePolicyRbac') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    SELECT gen_random_uuid(), g.role_id, 'OverridePolicy', g.override_scope
    FROM (
        SELECT DISTINCT np."CustomRoleId" AS role_id, m.override_scope
        FROM "CustomRolePermissions" np
        JOIN (VALUES
            ('Read', 'Read'),
            ('Manage', 'Read'),
            ('Manage', 'Write'),
            ('Manage', 'Delete')
        ) AS m(np_scope, override_scope) ON m.np_scope = np."Scope"
        WHERE np."Resource" = 'NetworkPolicy'
    ) AS g
    WHERE NOT EXISTS (
        SELECT 1 FROM "CustomRolePermissions" p
        WHERE p."CustomRoleId" = g.role_id
          AND p."Resource"     = 'OverridePolicy'
          AND p."Scope"        = g.override_scope
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261030130208_OverridePolicyRbac') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261030130208_OverridePolicyRbac', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261030173215_AdminPolicyRecordVia') THEN
    ALTER TABLE "AdminPolicyRecords" ADD "Via" character varying(64);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261030173215_AdminPolicyRecordVia') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261030173215_AdminPolicyRecordVia', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261031064521_AdminPolicyRuleHits') THEN
    CREATE TABLE "AdminPolicyRuleHits" (
        "ClusterName" character varying(200) NOT NULL,
        "Kind" character varying(64) NOT NULL,
        "Name" character varying(253) NOT NULL,
        "Direction" character varying(16) NOT NULL,
        "RuleIndex" integer NOT NULL,
        "HourStart" timestamp with time zone NOT NULL,
        "AclCount" bigint NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_AdminPolicyRuleHits" PRIMARY KEY ("ClusterName", "Kind", "Name", "Direction", "RuleIndex", "HourStart")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261031064521_AdminPolicyRuleHits') THEN
    CREATE INDEX "IX_AdminPolicyRuleHits_HourStart" ON "AdminPolicyRuleHits" ("HourStart");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261031064521_AdminPolicyRuleHits') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261031064521_AdminPolicyRuleHits', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261101061918_ThreatIntelAbuseChAuthKey') THEN
    ALTER TABLE "ThreatIntelSettings" ADD "AbuseChAuthKey" character varying(512);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261101061918_ThreatIntelAbuseChAuthKey') THEN
    UPDATE "ThreatIntelFeeds"
       SET "Url" = 'https://urlhaus-api.abuse.ch/v2/files/exports/{auth-key}/hostfile.txt',
           "EntryCount" = 0, "LastSizeBytes" = NULL, "LastError" = NULL
     WHERE "Key" = 'urlhaus' AND "IsBuiltIn"
       AND "Url" IN ('https://urlhaus.abuse.ch/downloads/text/',
                     'https://urlhaus.abuse.ch/downloads/text_online/',
                     'https://urlhaus.abuse.ch/downloads/hostfile/');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261101061918_ThreatIntelAbuseChAuthKey') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261101061918_ThreatIntelAbuseChAuthKey', '10.0.12');
    END IF;
END $EF$;
COMMIT;


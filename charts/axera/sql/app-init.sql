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
    VALUES ('e838e308-8394-4d56-960a-2dfa4c988c49', '00000001-0000-0000-0000-000000000001', 'NetworkPolicy', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('09719ffd-6fa0-456e-8a9d-b6a58750fd40', '00000001-0000-0000-0000-000000000001', 'NetworkPolicy', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('ee148e18-e261-4850-beab-183bf85628c9', '00000001-0000-0000-0000-000000000001', 'NetworkPolicy', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('e46019fe-3185-4937-bdf4-c2981c5b24da', '00000001-0000-0000-0000-000000000001', 'GlobalWhitelistPolicy', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('1fb27bde-870f-4cef-b611-5629306c8088', '00000001-0000-0000-0000-000000000001', 'GlobalWhitelistPolicy', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('1fa94b0b-2d12-4c24-97b8-5540c0451a67', '00000001-0000-0000-0000-000000000001', 'GlobalWhitelistPolicy', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('f2d0c72a-285c-49cf-8782-e6bf89783e66', '00000001-0000-0000-0000-000000000001', 'GitProviderSettings', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('d67ece09-ee31-4991-b875-4d25ae6f48dd', '00000001-0000-0000-0000-000000000001', 'TicketingProviderSettings', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('b4b894ab-e9b7-4fd9-ae52-be1363ed1e3d', '00000001-0000-0000-0000-000000000001', 'LdapConnection', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('7c122bdb-7dd6-4eeb-aa1c-0e73e57c3d79', '00000001-0000-0000-0000-000000000001', 'OpenShiftIntegration', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('d9e2d0c8-072d-46c4-9f34-dbc7963998fe', '00000001-0000-0000-0000-000000000001', 'License', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('9ce2d2d2-6317-48e9-81c2-5fd5e915a1ac', '00000001-0000-0000-0000-000000000001', 'License', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('9dec98e5-8f4a-4535-b55c-0d830bad4c06', '00000001-0000-0000-0000-000000000001', 'SetupThirdParty', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('4380de93-bc31-4918-acf6-e11636b522a4', '00000001-0000-0000-0000-000000000001', 'SetupThirdParty', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('8912a774-061b-4c24-9229-0f0b632b7b8b', '00000001-0000-0000-0000-000000000001', 'SetupThirdParty', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('6e302fb0-b755-4fdd-8cec-af42ad0f0638', '00000001-0000-0000-0000-000000000001', 'UserManagement', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('b7f1be25-4c8d-4c98-ac26-17955468b139', '00000001-0000-0000-0000-000000000001', 'UserSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('cffbc40d-ae2a-498d-b471-c8de27f3ee53', '00000001-0000-0000-0000-000000000001', 'UserSettings', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('301424cb-b0e6-44d8-a103-32c0572effeb', '00000001-0000-0000-0000-000000000001', 'KubernetesPush', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('b4307ccd-15f0-44b9-a618-3be0463277e9', '00000001-0000-0000-0000-000000000001', 'NetworkPolicyFlow', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('e35c7b2c-93df-4ac8-8992-ca65a8659cbb', '00000001-0000-0000-0000-000000000001', 'Jira', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('851f80f3-eea2-4060-8779-2df630a8c13c', '00000001-0000-0000-0000-000000000001', 'Jira', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('6aa270a3-ec3a-499b-a27e-c650c92a6dd9', '00000001-0000-0000-0000-000000000001', 'Proxy', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('437e7bf9-cec6-45d1-99c3-88b5149513c5', '00000001-0000-0000-0000-000000000001', 'RadarFlow', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('47e77a0e-a55c-4a0c-a7cb-dff793be8ce9', '00000001-0000-0000-0000-000000000001', 'RadarCollection', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('11339854-fba4-4834-ba81-23b28d28745d', '00000001-0000-0000-0000-000000000001', 'RadarCollection', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('4936a139-0d55-4816-84d7-e508df09f75d', '00000001-0000-0000-0000-000000000001', 'RadarCollection', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('46d22803-0a04-4d72-bebf-5dbfa63ed03c', '00000001-0000-0000-0000-000000000001', 'AllowDropMonitor', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('f80f3196-1c5e-405a-82bd-431757d297a2', '00000001-0000-0000-0000-000000000001', 'Settings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('26f86a09-1c00-4e0c-8322-ef600f559c2a', '00000001-0000-0000-0000-000000000001', 'Settings', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('2151ccc9-a604-4856-a5be-23d25f68614c', '00000001-0000-0000-0000-000000000001', 'WatcherSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('80e8e540-54b0-46e5-bfa0-b10554cc6642', '00000001-0000-0000-0000-000000000001', 'WatcherSettings', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('1405ccd3-8b70-41ca-bef6-9d652733e602', '00000001-0000-0000-0000-000000000001', 'Analytics', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('5c2b2a58-6301-42a3-957f-76b738024e4b', '00000001-0000-0000-0000-000000000001', 'Analytics', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('a16b6957-0196-4663-a743-2fcda4511b8e', '00000001-0000-0000-0000-000000000001', 'Analytics', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('d5caed37-a22b-4e23-806e-82312d7b7347', '00000002-0000-0000-0000-000000000002', 'NetworkPolicy', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('c5008c00-1473-4e66-abff-685436c4ad26', '00000002-0000-0000-0000-000000000002', 'NetworkPolicy', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('1697d4fb-6dca-4802-b788-17fac35a970b', '00000002-0000-0000-0000-000000000002', 'NetworkPolicy', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('aeb58329-a633-4e75-a585-be9054b00989', '00000002-0000-0000-0000-000000000002', 'GlobalWhitelistPolicy', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('74cac46f-88e8-4fa9-af55-084dff64793f', '00000002-0000-0000-0000-000000000002', 'GlobalWhitelistPolicy', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('c3b3f83e-72d6-48c5-99c8-be4163e761d9', '00000002-0000-0000-0000-000000000002', 'GlobalWhitelistPolicy', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('daa941e3-374b-40c0-9ef7-1c51a9b4887d', '00000002-0000-0000-0000-000000000002', 'GitProviderSettings', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('a1f9030c-96c6-4780-853e-0ae946474c68', '00000002-0000-0000-0000-000000000002', 'TicketingProviderSettings', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('25fc12ba-ca3d-43e4-9c7d-ab4637271a63', '00000002-0000-0000-0000-000000000002', 'SetupThirdParty', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('a23d88ac-c0d3-4657-bcf7-56ad91182751', '00000002-0000-0000-0000-000000000002', 'UserSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('b5d7c23b-29df-438f-977a-0a8ed0766c33', '00000002-0000-0000-0000-000000000002', 'UserSettings', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('17afab16-649f-48d0-a88e-51120df79f21', '00000002-0000-0000-0000-000000000002', 'KubernetesPush', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('7f89c03a-e9f9-49c9-a7d9-c2028a95f0d2', '00000002-0000-0000-0000-000000000002', 'NetworkPolicyFlow', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('ceda077e-bd69-4c37-b1d7-ce34f6e2b1ae', '00000002-0000-0000-0000-000000000002', 'Jira', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('7de03c47-a092-4614-be6b-356045483895', '00000002-0000-0000-0000-000000000002', 'Jira', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('98823c5e-b692-41d6-8f39-b6b4099ea35b', '00000002-0000-0000-0000-000000000002', 'Proxy', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('935f6444-f100-42ef-92ca-5e1a63fbb6b7', '00000002-0000-0000-0000-000000000002', 'RadarFlow', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('0fb10000-8a72-47c4-9fd6-809650aca2d3', '00000002-0000-0000-0000-000000000002', 'RadarCollection', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('3d67e580-a94a-4a59-bd12-6fb8f5fe7930', '00000002-0000-0000-0000-000000000002', 'RadarCollection', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('990b091e-bb84-45dc-82c6-057915c0a247', '00000002-0000-0000-0000-000000000002', 'RadarCollection', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('90bd6d86-ada2-4a47-8dc7-7e2344c9bca6', '00000002-0000-0000-0000-000000000002', 'AllowDropMonitor', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('43d54756-9ca4-4815-a573-b73188bb546b', '00000002-0000-0000-0000-000000000002', 'Settings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('b3b0f03c-5e2c-49e5-970b-a80584af7e59', '00000002-0000-0000-0000-000000000002', 'WatcherSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('12d1a24c-5578-4ab5-91d7-56ad8fffc80a', '00000002-0000-0000-0000-000000000002', 'Analytics', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('f2684e5f-3b0a-48a0-87f1-0afeb74367b9', '00000002-0000-0000-0000-000000000002', 'Analytics', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('43858364-d263-4b0a-9688-e46068edd41f', '00000002-0000-0000-0000-000000000002', 'Analytics', 'Delete');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('59d30269-3392-419d-8ae8-a5642bf993cc', '00000003-0000-0000-0000-000000000003', 'SetupThirdParty', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('f2473e3a-1893-45d9-8bf7-476606afadf3', '00000003-0000-0000-0000-000000000003', 'UserSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('01999dee-e7fd-4a3a-b03d-bf31277c7e98', '00000003-0000-0000-0000-000000000003', 'UserSettings', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('163e729c-71a8-401f-9d54-a602f9d844ab', '00000003-0000-0000-0000-000000000003', 'Jira', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('ca7dab5b-4809-4de7-82de-cf043f13f994', '00000003-0000-0000-0000-000000000003', 'Proxy', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('89915200-803d-4251-8d32-e6297df8280f', '00000003-0000-0000-0000-000000000003', 'RadarFlow', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('732879e2-44d6-4a6e-b21d-4b120fb8136c', '00000003-0000-0000-0000-000000000003', 'RadarCollection', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('3d984618-2e51-407b-bc94-069ca8e5c053', '00000003-0000-0000-0000-000000000003', 'AllowDropMonitor', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('08b10e9e-eb8e-491e-ad9b-28c0d3f5bcd8', '00000003-0000-0000-0000-000000000003', 'WatcherSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('692ab50b-b3aa-4d2d-b8b1-180db96bf0d6', '00000003-0000-0000-0000-000000000003', 'Analytics', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('46aa26d3-ab44-4b59-b18d-0cb164263465', '00000004-0000-0000-0000-000000000004', 'SetupThirdParty', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('c1d2ec30-4b3d-4652-8ac7-1303d7a7df45', '00000004-0000-0000-0000-000000000004', 'UserSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('e0406ee8-0c63-4c69-9fb5-f7b504653f4c', '00000004-0000-0000-0000-000000000004', 'UserSettings', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('3cda7f71-907a-49f5-8340-2e6b8000d56d', '00000004-0000-0000-0000-000000000004', 'Proxy', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('f56bd7a0-757c-4461-824c-176dd459a91b', '00000004-0000-0000-0000-000000000004', 'RadarFlow', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('2813dce4-e671-4366-9c00-e4a2f3affc55', '00000004-0000-0000-0000-000000000004', 'RadarCollection', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('0b1f63fb-9441-4eaf-b7ee-02e6fb905293', '00000004-0000-0000-0000-000000000004', 'AllowDropMonitor', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260515000000_CustomRoleBuilder') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('3cf6c17d-a4bc-4650-b726-feb5fc6d03e9', '00000004-0000-0000-0000-000000000004', 'WatcherSettings', 'Read');
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
    VALUES ('20260817074250_AddKubernetesIamGovernance', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819063313_AddIamEffectivePermissionRoleIndex') THEN
    CREATE INDEX "IX_EffectivePermissions_Cluster_SourceRole" ON "EffectivePermissions" ("ClusterName", "SourceRoleKey");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819063313_AddIamEffectivePermissionRoleIndex') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260819063313_AddIamEffectivePermissionRoleIndex', '10.0.12');
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
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    ALTER TABLE "UserSettings" ADD "IamAccessFlowConfig" jsonb;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    CREATE TABLE "DirectoryGroupMemberships" (
        "Id" uuid NOT NULL,
        "UserName" character varying(256) NOT NULL,
        "GroupCn" character varying(256) NOT NULL,
        "GroupDn" character varying(1024) NOT NULL,
        "SyncedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_DirectoryGroupMemberships" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    CREATE INDEX "IX_DirectoryGroupMemberships_Group" ON "DirectoryGroupMemberships" ("GroupCn");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    CREATE UNIQUE INDEX "IX_DirectoryGroupMemberships_User_Group" ON "DirectoryGroupMemberships" ("UserName", "GroupCn");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    INSERT INTO "CustomRoles" ("Id", "Name", "Description", "IsBuiltIn", "CreatedAt", "UpdatedAt")
    VALUES ('00000005-0000-0000-0000-000000000005', 'IamGeneralApprover', 'Approves Identity access requests that no owner has been assigned for. Can read the inventory and governance reports, but cannot reassign ownership.', TRUE, TIMESTAMPTZ '2026-08-19T00:00:00Z', TIMESTAMPTZ '2026-08-19T00:00:00Z');
    INSERT INTO "CustomRoles" ("Id", "Name", "Description", "IsBuiltIn", "CreatedAt", "UpdatedAt")
    VALUES ('00000006-0000-0000-0000-000000000006', 'IamAdmin', 'Full control of the Identity module: inventory, requests, approvals and governance. Can decide any request as an override, but never their own.', TRUE, TIMESTAMPTZ '2026-08-19T00:00:00Z', TIMESTAMPTZ '2026-08-19T00:00:00Z');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('981af793-a5be-44b1-bef6-085f5df01258', '00000005-0000-0000-0000-000000000005', 'IamApprovals', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('dc27bd7f-5f77-4dcb-85f5-d07e6afcd5a5', '00000005-0000-0000-0000-000000000005', 'IamRequests', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('ecabc442-12a3-4bf9-b640-cd41dc14faed', '00000005-0000-0000-0000-000000000005', 'IamInventory', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('4fc39eb1-8a71-4e3a-ade9-db50bf9493fe', '00000005-0000-0000-0000-000000000005', 'IamGovernance', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('69f75739-2eec-4464-b6c6-348600e30d4b', '00000005-0000-0000-0000-000000000005', 'SetupThirdParty', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('c896d1dc-93d1-4746-a7a6-fe9158f2a78b', '00000005-0000-0000-0000-000000000005', 'UserSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('2349fe38-04b5-49c8-a8bc-250245fccf26', '00000005-0000-0000-0000-000000000005', 'UserSettings', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('969b776c-3138-4f4c-ac82-ffc822b654c7', '00000006-0000-0000-0000-000000000006', 'IamInventory', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('f9808151-9e66-4ebe-9ac2-6d028a52f4d3', '00000006-0000-0000-0000-000000000006', 'IamRequests', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('3af63003-0b1d-449e-a3be-c076317e6626', '00000006-0000-0000-0000-000000000006', 'IamApprovals', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('56a2500a-65b1-4d85-8a23-7c86e1531c67', '00000006-0000-0000-0000-000000000006', 'IamGovernance', 'Manage');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('b3b47158-dbd6-4655-824e-f11407fbd8ff', '00000006-0000-0000-0000-000000000006', 'SetupThirdParty', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('da0f8984-8ef2-44a7-8a56-ec59aee57642', '00000006-0000-0000-0000-000000000006', 'UserSettings', 'Read');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    VALUES ('1267ada0-67c7-45ef-b273-4f066a562573', '00000006-0000-0000-0000-000000000006', 'UserSettings', 'Write');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260819170640_AddIamOwnershipRolesAndDirectoryGroups') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260819170640_AddIamOwnershipRolesAndDirectoryGroups', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260821224652_AddIamScopeOwners') THEN
    CREATE TABLE "ScopeOwners" (
        "Id" uuid NOT NULL,
        "Scope" character varying(16) NOT NULL,
        "ClusterName" character varying(256) NOT NULL,
        "Namespace" character varying(256),
        "OwnerType" character varying(32) NOT NULL,
        "OwnerRef" character varying(512) NOT NULL,
        "OwnerDisplayName" character varying(512),
        "BackupOwnerType" character varying(32),
        "BackupOwnerRef" character varying(512),
        "Source" character varying(16) NOT NULL,
        "AssignedBy" character varying(256) NOT NULL,
        "AssignedAt" timestamp with time zone NOT NULL,
        "IsStale" boolean NOT NULL,
        CONSTRAINT "PK_ScopeOwners" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260821224652_AddIamScopeOwners') THEN
    CREATE UNIQUE INDEX "IX_ScopeOwners_Cluster" ON "ScopeOwners" ("ClusterName") WHERE "Namespace" IS NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260821224652_AddIamScopeOwners') THEN
    CREATE UNIQUE INDEX "IX_ScopeOwners_Namespace" ON "ScopeOwners" ("ClusterName", "Namespace") WHERE "Namespace" IS NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260821224652_AddIamScopeOwners') THEN
    CREATE INDEX "IX_ScopeOwners_OwnerRef" ON "ScopeOwners" ("OwnerRef");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260821224652_AddIamScopeOwners') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260821224652_AddIamScopeOwners', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822064013_AddIamRequestDeliveryOptions') THEN
    ALTER TABLE "AccessRequests" ADD "ClusterAppliedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822064013_AddIamRequestDeliveryOptions') THEN
    ALTER TABLE "AccessRequests" ADD "CreateTicket" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822064013_AddIamRequestDeliveryOptions') THEN
    ALTER TABLE "AccessRequests" ADD "DeliverToCluster" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822064013_AddIamRequestDeliveryOptions') THEN
    ALTER TABLE "AccessRequests" ADD "DeliverToGit" boolean NOT NULL DEFAULT TRUE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822064013_AddIamRequestDeliveryOptions') THEN
    ALTER TABLE "AccessRequests" ADD "TicketKey" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822064013_AddIamRequestDeliveryOptions') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260822064013_AddIamRequestDeliveryOptions', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    DROP INDEX "IX_IdentityOwners_Identity";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "IdentityOwners" ALTER COLUMN "IdentityId" DROP NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "IdentityOwners" ADD "EntitlementType" character varying(16) NOT NULL DEFAULT 'Identity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "IdentityOwners" ADD "RoleId" uuid;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "AttestationCampaigns" ADD "EntitlementPattern" character varying(512);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "AttestationCampaigns" ADD "EntitlementType" character varying(16) NOT NULL DEFAULT 'Identity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "AttestationCampaigns" ADD "NamespacePattern" character varying(512);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "AttestationCampaigns" ADD "SecondReviewer" character varying(32) NOT NULL DEFAULT 'None';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "AttestationCampaignItems" ALTER COLUMN "IdentityId" DROP NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "EntitlementType" character varying(16) NOT NULL DEFAULT 'Identity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "IsResolved" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "Namespace" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "RoleId" uuid;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "SecondDecidedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "SecondDecidedBy" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "SecondDecision" character varying(16) NOT NULL DEFAULT 'Pending';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "SecondReviewerRef" character varying(512);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    CREATE UNIQUE INDEX "IX_IdentityOwners_Identity" ON "IdentityOwners" ("IdentityId") WHERE "IdentityId" IS NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    CREATE UNIQUE INDEX "IX_IdentityOwners_Role" ON "IdentityOwners" ("RoleId") WHERE "RoleId" IS NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    CREATE INDEX "IX_AttestationCampaignItems_Reviewer_Open" ON "AttestationCampaignItems" ("ReviewerRef", "IsResolved");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    CREATE INDEX "IX_AttestationCampaignItems_SecondReviewer_Open" ON "AttestationCampaignItems" ("SecondReviewerRef", "IsResolved");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    ALTER TABLE "IdentityOwners" ADD CONSTRAINT "FK_IdentityOwners_RbacRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "RbacRoles" ("Id") ON DELETE CASCADE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    UPDATE "AttestationCampaignItems"
    SET "IsResolved" = true
    WHERE "Decision" <> 'Pending';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822080300_AddEntitlementOwnershipAndAttestationV2') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260822080300_AddEntitlementOwnershipAndAttestationV2', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    UPDATE "CustomRoles" SET "Name" = 'IAM Admin' WHERE "Name" = 'IamAdmin';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    UPDATE "AspNetRoles" SET "Name" = 'IAM Admin', "NormalizedName" = 'IAM ADMIN' WHERE "Name" = 'IamAdmin';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    UPDATE "AspNetUsers" SET "Role" = 'IAM Admin' WHERE "Role" = 'IamAdmin';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    UPDATE "ADRoleMappings" SET "ApplicationRole" = 'IAM Admin' WHERE "ApplicationRole" = 'IamAdmin';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    UPDATE "ApprovalSteps" SET "ApproverRef" = 'Role:IAM Admin' WHERE "ApproverRef" = 'Role:IamAdmin';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    UPDATE "CustomRoles" SET "Name" = 'IAM Approver' WHERE "Name" = 'IamGeneralApprover';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    UPDATE "AspNetRoles" SET "Name" = 'IAM Approver', "NormalizedName" = 'IAM APPROVER' WHERE "Name" = 'IamGeneralApprover';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    UPDATE "AspNetUsers" SET "Role" = 'IAM Approver' WHERE "Role" = 'IamGeneralApprover';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    UPDATE "ADRoleMappings" SET "ApplicationRole" = 'IAM Approver' WHERE "ApplicationRole" = 'IamGeneralApprover';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    UPDATE "ApprovalSteps" SET "ApproverRef" = 'Role:IAM Approver' WHERE "ApproverRef" = 'Role:IamGeneralApprover';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    INSERT INTO "CustomRoles" ("Id", "Name", "Description", "IsBuiltIn", "CreatedAt", "UpdatedAt")
    SELECT '00000007-0000-0000-0000-000000000007', 'IAM User',
           'Everyday use of the Identity module: browse the inventory and raise access requests. Approves nothing and owns nothing.',
           true, TIMESTAMPTZ '2026-08-22 00:00:00+00', TIMESTAMPTZ '2026-08-22 00:00:00+00'
    WHERE NOT EXISTS (SELECT 1 FROM "CustomRoles" WHERE "Id" = '00000007-0000-0000-0000-000000000007');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    SELECT gen_random_uuid(), '00000007-0000-0000-0000-000000000007', 'IamInventory', 'Read'
    WHERE NOT EXISTS (
        SELECT 1 FROM "CustomRolePermissions"
        WHERE "CustomRoleId" = '00000007-0000-0000-0000-000000000007' AND "Resource" = 'IamInventory' AND "Scope" = 'Read'
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    SELECT gen_random_uuid(), '00000007-0000-0000-0000-000000000007', 'IamRequests', 'Read'
    WHERE NOT EXISTS (
        SELECT 1 FROM "CustomRolePermissions"
        WHERE "CustomRoleId" = '00000007-0000-0000-0000-000000000007' AND "Resource" = 'IamRequests' AND "Scope" = 'Read'
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    SELECT gen_random_uuid(), '00000007-0000-0000-0000-000000000007', 'IamRequests', 'Write'
    WHERE NOT EXISTS (
        SELECT 1 FROM "CustomRolePermissions"
        WHERE "CustomRoleId" = '00000007-0000-0000-0000-000000000007' AND "Resource" = 'IamRequests' AND "Scope" = 'Write'
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    SELECT gen_random_uuid(), '00000007-0000-0000-0000-000000000007', 'SetupThirdParty', 'Read'
    WHERE NOT EXISTS (
        SELECT 1 FROM "CustomRolePermissions"
        WHERE "CustomRoleId" = '00000007-0000-0000-0000-000000000007' AND "Resource" = 'SetupThirdParty' AND "Scope" = 'Read'
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    SELECT gen_random_uuid(), '00000007-0000-0000-0000-000000000007', 'UserSettings', 'Read'
    WHERE NOT EXISTS (
        SELECT 1 FROM "CustomRolePermissions"
        WHERE "CustomRoleId" = '00000007-0000-0000-0000-000000000007' AND "Resource" = 'UserSettings' AND "Scope" = 'Read'
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    SELECT gen_random_uuid(), '00000007-0000-0000-0000-000000000007', 'UserSettings', 'Write'
    WHERE NOT EXISTS (
        SELECT 1 FROM "CustomRolePermissions"
        WHERE "CustomRoleId" = '00000007-0000-0000-0000-000000000007' AND "Resource" = 'UserSettings' AND "Scope" = 'Write'
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260822090000_RenameIamRolesAndAddIamUser') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260822090000_RenameIamRolesAndAddIamUser', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260825090000_GrantIamUserApprovalScopes') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    SELECT gen_random_uuid(), '00000007-0000-0000-0000-000000000007', 'IamApprovals', 'Read'
    WHERE EXISTS (SELECT 1 FROM "CustomRoles" WHERE "Id" = '00000007-0000-0000-0000-000000000007')
      AND NOT EXISTS (
        SELECT 1 FROM "CustomRolePermissions"
        WHERE "CustomRoleId" = '00000007-0000-0000-0000-000000000007' AND "Resource" = 'IamApprovals' AND "Scope" = 'Read'
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260825090000_GrantIamUserApprovalScopes') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    SELECT gen_random_uuid(), '00000007-0000-0000-0000-000000000007', 'IamApprovals', 'Write'
    WHERE EXISTS (SELECT 1 FROM "CustomRoles" WHERE "Id" = '00000007-0000-0000-0000-000000000007')
      AND NOT EXISTS (
        SELECT 1 FROM "CustomRolePermissions"
        WHERE "CustomRoleId" = '00000007-0000-0000-0000-000000000007' AND "Resource" = 'IamApprovals' AND "Scope" = 'Write'
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260825090000_GrantIamUserApprovalScopes') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260825090000_GrantIamUserApprovalScopes', '10.0.12');
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
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260827090000_AddCampaignOwnedOnly') THEN
    ALTER TABLE "AttestationCampaigns"
    ADD COLUMN IF NOT EXISTS "OwnedOnly" boolean NOT NULL DEFAULT false;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260827090000_AddCampaignOwnedOnly') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260827090000_AddCampaignOwnedOnly', '10.0.12');
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
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260902090000_AddIamReportSchedules') THEN
    ALTER TABLE "IamSettings"
    ADD COLUMN IF NOT EXISTS "ReportSchedulesJson" text NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260902090000_AddIamReportSchedules') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260902090000_AddIamReportSchedules', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260904090000_AddIamResyncMinutes') THEN
    ALTER TABLE "IamSettings"
    ADD COLUMN IF NOT EXISTS "FullResyncIntervalMinutes" integer NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260904090000_AddIamResyncMinutes') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260904090000_AddIamResyncMinutes', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260904120000_AddIamAllowSelfApproval') THEN
    ALTER TABLE "IamSettings"
    ADD COLUMN IF NOT EXISTS "AllowSelfApproval" boolean NOT NULL DEFAULT false;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260904120000_AddIamAllowSelfApproval') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260904120000_AddIamAllowSelfApproval', '10.0.12');
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
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260905090000_AddIamPerClusterResync') THEN
    ALTER TABLE "IamClusterSyncStates"
    ADD COLUMN IF NOT EXISTS "ResyncIntervalMinutes" integer NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20260905090000_AddIamPerClusterResync') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20260905090000_AddIamPerClusterResync', '10.0.12');
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
    ALTER TABLE "SetupThirdParties" ADD "ExcessPrivileges" text[];
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "SetupThirdParties" ADD "LastPrivilegeCheckAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "SetupThirdParties" ADD "LastPrivilegeCheckError" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "ScanRepositories" ADD "CredentialOwnerUserId" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "PolicyHitDaily" ADD "AclCount" bigint NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "PolicyHitDaily" ADD "FlowCount" bigint NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "OldNetworkPolicyRecords" ADD "SavedBy" character varying(256) NOT NULL DEFAULT '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "AclHitCount" bigint NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "DeployedSpecHash" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "DeployedVersionNumber" integer;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "FlowHitCount" bigint NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "LiveDriftDetectedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "NetworkPolicyRecords" ADD "SavedBy" character varying(256) NOT NULL DEFAULT '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "MeshRecertificationAttestations" ADD "EvidenceFromUtc" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowAiSettingsWrite" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowAnalyticsSettingsWrite" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowBackupCreate" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowBackupSettingsWrite" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowCaptureCreate" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowLicenseWrite" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowLoggingReconfigure" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "McpWriteGateSettings" ADD "AllowNetworkPolicyRecordMigration" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "LDAPConnections" ADD "DisplayName" character varying(128);
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
    CREATE TABLE "AnalyticsAlertFirings" (
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
    CREATE TABLE "PolicyRecommendationSnapshots" (
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
    ALTER TABLE "WatcherSettings" ADD CONSTRAINT "CK_WatcherSettings_AddedEventAction" CHECK ("AddedEventAction" IN (1, 2, 3));
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "WatcherSettings" ADD CONSTRAINT "CK_WatcherSettings_DeletedEventAction" CHECK ("DeletedEventAction" IN (1, 2, 3));
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    ALTER TABLE "WatcherSettings" ADD CONSTRAINT "CK_WatcherSettings_ModifiedEventAction" CHECK ("ModifiedEventAction" IN (1, 2, 3));
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    CREATE UNIQUE INDEX "IX_AnalyticsSavedViews_OwnerUserId_Name" ON "AnalyticsSavedViews" ("OwnerUserId", "Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261004085500_AxeraV1330AppSchema') THEN
    CREATE INDEX "IX_AnalyticsAlertFirings_FiredAt" ON "AnalyticsAlertFirings" ("FiredAt");
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
    CREATE TABLE "PersonalAccessTokens" (
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
    CREATE INDEX "IX_PersonalAccessTokens_UserId" ON "PersonalAccessTokens" ("UserId");
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
    ALTER TABLE "PersonalAccessTokens" ADD "LastUsedIp" character varying(64);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261007110243_AddApiTokenScopesAndLastUsedAddress') THEN
    ALTER TABLE "PersonalAccessTokens" ADD "LastUsedUserAgent" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261007110243_AddApiTokenScopesAndLastUsedAddress') THEN
    ALTER TABLE "PersonalAccessTokens" ADD "Scopes" character varying(8000);
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
    ALTER TABLE "PersonalAccessTokens" ADD "Audience" character varying(2000);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    ALTER TABLE "PersonalAccessTokens" ADD "OAuthClientId" uuid;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    ALTER TABLE "PersonalAccessTokens" ADD "PreviousRefreshTokenHash" character varying(64);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    ALTER TABLE "PersonalAccessTokens" ADD "RefreshExpiresAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    ALTER TABLE "PersonalAccessTokens" ADD "RefreshRotatedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    ALTER TABLE "PersonalAccessTokens" ADD "RefreshTokenHash" character varying(64);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE TABLE "OAuthClients" (
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
    CREATE TABLE "OAuthAuthorizationCodes" (
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
    CREATE INDEX "IX_PersonalAccessTokens_OAuthClientId" ON "PersonalAccessTokens" ("OAuthClientId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE INDEX "IX_PersonalAccessTokens_PreviousRefreshTokenHash" ON "PersonalAccessTokens" ("PreviousRefreshTokenHash");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE UNIQUE INDEX "IX_PersonalAccessTokens_RefreshTokenHash" ON "PersonalAccessTokens" ("RefreshTokenHash");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE UNIQUE INDEX "IX_OAuthAuthorizationCodes_CodeHash" ON "OAuthAuthorizationCodes" ("CodeHash");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE INDEX "IX_OAuthAuthorizationCodes_ExpiresAt" ON "OAuthAuthorizationCodes" ("ExpiresAt");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE INDEX "IX_OAuthAuthorizationCodes_OAuthClientId" ON "OAuthAuthorizationCodes" ("OAuthClientId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE INDEX "IX_OAuthAuthorizationCodes_UserId" ON "OAuthAuthorizationCodes" ("UserId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    CREATE UNIQUE INDEX "IX_OAuthClients_ClientId" ON "OAuthClients" ("ClientId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261008131628_AddOAuthClients') THEN
    ALTER TABLE "PersonalAccessTokens" ADD CONSTRAINT "FK_PersonalAccessTokens_OAuthClients_OAuthClientId" FOREIGN KEY ("OAuthClientId") REFERENCES "OAuthClients" ("Id") ON DELETE CASCADE;
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
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020090000_GrantIamApproverApprovalRead') THEN
    INSERT INTO "CustomRolePermissions" ("Id", "CustomRoleId", "Resource", "Scope")
    SELECT gen_random_uuid(), '00000005-0000-0000-0000-000000000005', 'IamApprovals', 'Read'
    WHERE EXISTS (SELECT 1 FROM "CustomRoles" WHERE "Id" = '00000005-0000-0000-0000-000000000005')
      AND NOT EXISTS (
        SELECT 1 FROM "CustomRolePermissions"
        WHERE "CustomRoleId" = '00000005-0000-0000-0000-000000000005' AND "Resource" = 'IamApprovals' AND "Scope" = 'Read'
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020090000_GrantIamApproverApprovalRead') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261020090000_GrantIamApproverApprovalRead', '10.0.12');
    END IF;
END $EF$;
COMMIT;


START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    DROP INDEX "IX_DirectoryGroupMemberships_User_Group";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    DELETE FROM "DirectoryGroupMemberships" a
    USING "DirectoryGroupMemberships" b
    WHERE a."UserName" = b."UserName" AND a."GroupDn" = b."GroupDn" AND a."Id" > b."Id";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    DELETE FROM "IamSettings"
    WHERE "Id" NOT IN (SELECT "Id" FROM "IamSettings" ORDER BY "UpdatedAt" DESC, "Id" LIMIT 1);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    UPDATE "IamIdentities" t SET "DeletedAt" = now()
    FROM (
        SELECT "Id", row_number() OVER (PARTITION BY "ClusterName", "Type", "Name" ORDER BY "FirstSeen", "Id") AS rn
        FROM "IamIdentities" WHERE "Namespace" IS NULL AND "DeletedAt" IS NULL
    ) d
    WHERE t."Id" = d."Id" AND d.rn > 1;

    UPDATE "RbacRoles" t SET "DeletedAt" = now()
    FROM (
        SELECT "Id", row_number() OVER (PARTITION BY "ClusterName", "Kind", "Name" ORDER BY "FirstSeen", "Id") AS rn
        FROM "RbacRoles" WHERE "Namespace" IS NULL AND "DeletedAt" IS NULL
    ) d
    WHERE t."Id" = d."Id" AND d.rn > 1;

    UPDATE "RbacBindings" t SET "DeletedAt" = now()
    FROM (
        SELECT "Id", row_number() OVER (PARTITION BY "ClusterName", "Kind", "Name" ORDER BY "FirstSeen", "Id") AS rn
        FROM "RbacBindings" WHERE "Namespace" IS NULL AND "DeletedAt" IS NULL
    ) d
    WHERE t."Id" = d."Id" AND d.rn > 1;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "BackupReviewerRef" character varying(512);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "BackupReviewerType" character varying(32);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "ClusterName" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "ReviewerType" character varying(32);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "SecondBackupReviewerRef" character varying(512);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "SecondBackupReviewerType" character varying(32);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "SecondComment" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "SecondReviewerType" character varying(32);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    ALTER TABLE "AccessRequests" ADD "DeliveryStartedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    CREATE UNIQUE INDEX "IX_RbacRoles_ClusterScopedKey" ON "RbacRoles" ("ClusterName", "Kind", "Name") WHERE "Namespace" IS NULL AND "DeletedAt" IS NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    CREATE UNIQUE INDEX "IX_RbacBindings_ClusterScopedKey" ON "RbacBindings" ("ClusterName", "Kind", "Name") WHERE "Namespace" IS NULL AND "DeletedAt" IS NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    CREATE UNIQUE INDEX "IX_IamIdentities_ClusterScopedKey" ON "IamIdentities" ("ClusterName", "Type", "Name") WHERE "Namespace" IS NULL AND "DeletedAt" IS NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    CREATE UNIQUE INDEX "IX_DirectoryGroupMemberships_User_GroupDn" ON "DirectoryGroupMemberships" ("UserName", "GroupDn");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020100000_KiamReadinessRound1') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261020100000_KiamReadinessRound1', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    DROP INDEX "IX_EffectivePermissions_Cluster_SourceRole";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    ALTER TABLE "AttestationCampaigns" ADD "ReminderSentAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "PermissionCount" integer NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "RevokeNote" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    ALTER TABLE "AttestationCampaignItems" ADD "RevokeRequestIdsJson" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    ALTER TABLE "ApprovalSteps" ADD "DelegatedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    ALTER TABLE "ApprovalSteps" ADD "DelegatedBy" character varying(256);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    UPDATE "AttestationCampaignItems" SET "RevokeRequestIdsJson" = json_build_array("RevokeRequestId")::text
    WHERE "RevokeRequestId" IS NOT NULL AND "RevokeRequestIdsJson" IS NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    UPDATE "AttestationCampaignItems" SET "PermissionCount" = json_array_length("PermissionSummaryJson"::json)
    WHERE "PermissionCount" = 0 AND "PermissionSummaryJson" ~ '^\s*\[.*\]\s*$';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    DELETE FROM "AttestationCampaigns" c
    WHERE c."Status" = 'Draft' AND NOT EXISTS (SELECT 1 FROM "AttestationCampaignItems" i WHERE i."CampaignId" = c."Id");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    UPDATE "AttestationCampaigns" SET "ReviewerStrategy" = 'IdentityOwner' WHERE "ReviewerStrategy" IS DISTINCT FROM 'IdentityOwner';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    UPDATE "AttestationCampaignItems"
    SET "ReviewerRef" = btrim("ReviewerRef"), "BackupReviewerRef" = btrim("BackupReviewerRef"),
        "SecondReviewerRef" = btrim("SecondReviewerRef"), "SecondBackupReviewerRef" = btrim("SecondBackupReviewerRef"),
        "DelegatedTo" = btrim("DelegatedTo")
    WHERE "ReviewerRef" <> btrim("ReviewerRef") OR "BackupReviewerRef" <> btrim("BackupReviewerRef")
       OR "SecondReviewerRef" <> btrim("SecondReviewerRef") OR "SecondBackupReviewerRef" <> btrim("SecondBackupReviewerRef")
       OR "DelegatedTo" <> btrim("DelegatedTo");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    DELETE FROM "ScopeOwners" s
    USING (
        SELECT "Id", row_number() OVER (
            PARTITION BY btrim("ClusterName", E' \t\r\n'), "Namespace"
            ORDER BY ("ClusterName" = btrim("ClusterName", E' \t\r\n')) DESC, "AssignedAt" DESC, "Id"
        ) AS rn
        FROM "ScopeOwners"
    ) d
    WHERE s."Id" = d."Id" AND d.rn > 1;
    UPDATE "ScopeOwners" SET "ClusterName" = btrim("ClusterName", E' \t\r\n') WHERE "ClusterName" <> btrim("ClusterName", E' \t\r\n');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    UPDATE "IdentityOwners" SET
        "OwnerType" = CASE lower(btrim("OwnerType")) WHEN 'axerauser' THEN 'AxeraUser' WHEN 'ldapuser' THEN 'LdapUser' WHEN 'ldapgroup' THEN 'LdapGroup' ELSE "OwnerType" END,
        "OwnerRef" = btrim("OwnerRef", E' \t\r\n'),
        "BackupOwnerRef" = nullif(btrim("BackupOwnerRef", E' \t\r\n'), ''),
        "BackupOwnerType" = CASE
            WHEN nullif(btrim("BackupOwnerRef", E' \t\r\n'), '') IS NULL THEN NULL
            WHEN lower(btrim("BackupOwnerType")) = 'axerauser' THEN 'AxeraUser'
            WHEN lower(btrim("BackupOwnerType")) = 'ldapuser' THEN 'LdapUser'
            WHEN lower(btrim("BackupOwnerType")) = 'ldapgroup' THEN 'LdapGroup'
            ELSE "BackupOwnerType" END
    WHERE (lower(btrim("OwnerType")) IN ('axerauser','ldapuser','ldapgroup') AND "OwnerType" NOT IN ('AxeraUser','LdapUser','LdapGroup'))
       OR "OwnerRef" <> btrim("OwnerRef", E' \t\r\n')
       OR "BackupOwnerRef" IS DISTINCT FROM nullif(btrim("BackupOwnerRef", E' \t\r\n'), '')
       OR ("BackupOwnerType" IS NOT NULL AND nullif(btrim("BackupOwnerRef", E' \t\r\n'), '') IS NULL)
       OR (lower(btrim("BackupOwnerType")) IN ('axerauser','ldapuser','ldapgroup') AND "BackupOwnerType" NOT IN ('AxeraUser','LdapUser','LdapGroup'));

    UPDATE "ScopeOwners" SET
        "OwnerType" = CASE lower(btrim("OwnerType")) WHEN 'axerauser' THEN 'AxeraUser' WHEN 'ldapuser' THEN 'LdapUser' WHEN 'ldapgroup' THEN 'LdapGroup' ELSE "OwnerType" END,
        "OwnerRef" = btrim("OwnerRef", E' \t\r\n'),
        "BackupOwnerRef" = nullif(btrim("BackupOwnerRef", E' \t\r\n'), ''),
        "BackupOwnerType" = CASE
            WHEN nullif(btrim("BackupOwnerRef", E' \t\r\n'), '') IS NULL THEN NULL
            WHEN lower(btrim("BackupOwnerType")) = 'axerauser' THEN 'AxeraUser'
            WHEN lower(btrim("BackupOwnerType")) = 'ldapuser' THEN 'LdapUser'
            WHEN lower(btrim("BackupOwnerType")) = 'ldapgroup' THEN 'LdapGroup'
            ELSE "BackupOwnerType" END
    WHERE (lower(btrim("OwnerType")) IN ('axerauser','ldapuser','ldapgroup') AND "OwnerType" NOT IN ('AxeraUser','LdapUser','LdapGroup'))
       OR "OwnerRef" <> btrim("OwnerRef", E' \t\r\n')
       OR "BackupOwnerRef" IS DISTINCT FROM nullif(btrim("BackupOwnerRef", E' \t\r\n'), '')
       OR ("BackupOwnerType" IS NOT NULL AND nullif(btrim("BackupOwnerRef", E' \t\r\n'), '') IS NULL)
       OR (lower(btrim("BackupOwnerType")) IN ('axerauser','ldapuser','ldapgroup') AND "BackupOwnerType" NOT IN ('AxeraUser','LdapUser','LdapGroup'));
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    UPDATE "ApprovalSteps" SET "ApproverLabel" = 'Entitlement owner'
    WHERE "ApproverRef" = 'EntitlementOwner' AND ("ApproverLabel" IS NULL OR "ApproverLabel" = 'EntitlementOwner');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    DELETE FROM "EffectivePermissions" p USING "IamIdentities" i WHERE p."IdentityId" = i."Id" AND i."DeletedAt" IS NOT NULL;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    DELETE FROM "IamSettings" AS s
    WHERE EXISTS (
        SELECT 1 FROM "IamSettings" AS k
        WHERE k."UpdatedAt" > s."UpdatedAt" OR (k."UpdatedAt" = s."UpdatedAt" AND k."Id" < s."Id")
    );
    UPDATE "IamSettings" SET "Id" = '00000000-0000-0000-0000-000000000001' WHERE "Id" <> '00000000-0000-0000-0000-000000000001';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    ALTER TABLE "IamSettings" ADD CONSTRAINT "CK_IamSettings_Singleton" CHECK ("Id" = '00000000-0000-0000-0000-000000000001');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    CREATE INDEX "IX_EffectivePermissions_Cluster_SourceRole" ON "EffectivePermissions" ("ClusterName", "SourceRoleKey", "IdentityId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020110000_KiamReadinessRound2') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261020110000_KiamReadinessRound2', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020120000_KiamReadinessRound3') THEN
    ALTER TABLE "IamIdentities" ADD "MembersJson" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020120000_KiamReadinessRound3') THEN
    ALTER TABLE "IamClusterSyncStates" ADD "NoticesJson" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020120000_KiamReadinessRound3') THEN
    ALTER TABLE "AccessRequests" ADD "ExternalApprovalRef" character varying(128);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020120000_KiamReadinessRound3') THEN
    UPDATE "IamSettings" SET "RiskRulesJson" = NULL
    WHERE "RiskRulesJson" IS NOT NULL AND btrim("RiskRulesJson", E' \t\r\n') IN ('', 'null');
    UPDATE "IamSettings" SET "ApprovalMatrixJson" = NULL
    WHERE "ApprovalMatrixJson" IS NOT NULL AND btrim("ApprovalMatrixJson", E' \t\r\n') IN ('', 'null');
    UPDATE "IamSettings" SET "DriftExemptionsJson" = NULL
    WHERE "DriftExemptionsJson" IS NOT NULL AND btrim("DriftExemptionsJson", E' \t\r\n') IN ('', 'null');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020120000_KiamReadinessRound3') THEN
    UPDATE "IamSettings" SET "GitRootPath" = 'rbac'
    WHERE btrim("GitRootPath", E' \t\r\n/') = '' OR "GitRootPath" ~ '(^|/)\.{1,2}(/|$)' OR strpos("GitRootPath", E'\\') > 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020120000_KiamReadinessRound3') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261020120000_KiamReadinessRound3', '10.0.12');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020130000_KiamReadinessRound4') THEN
    ALTER TABLE "IamClusterSyncStates" ADD "LastSuccessfulSyncStartedAt" timestamp with time zone;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020130000_KiamReadinessRound4') THEN
    ALTER TABLE "IamClusterSyncStates" ADD "NamespaceOwnersJson" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020130000_KiamReadinessRound4') THEN
    ALTER TABLE "AttestationCampaigns" ADD "OpenNoticePending" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020130000_KiamReadinessRound4') THEN
    ALTER TABLE "ApprovalSteps" ADD "DecidedVia" character varying(32);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020130000_KiamReadinessRound4') THEN
    ALTER TABLE "ApprovalSteps" ADD "DelegationsJson" text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020130000_KiamReadinessRound4') THEN
    UPDATE "IamClusterSyncStates" AS s
    SET "Health" = CASE WHEN healed.rest = '' THEN 'Healthy' ELSE s."Health" END,
        "LastError" = NULLIF(healed.rest, ''),
        "NoticesJson" = CASE
            WHEN s."NoticesJson" IS NULL OR btrim(s."NoticesJson") IN ('', '[]')
                THEN '["Last sign-in signal unavailable (oauthaccesstokens not readable)"]'
            WHEN s."NoticesJson" LIKE '%Last sign-in signal unavailable%'
                THEN s."NoticesJson"
            ELSE (s."NoticesJson"::jsonb || '["Last sign-in signal unavailable (oauthaccesstokens not readable)"]'::jsonb)::text
        END
    FROM (
        SELECT st."Id",
               array_to_string(
                   ARRAY(
                       SELECT w.part
                       FROM unnest(string_to_array(st."LastError", ' | ')) WITH ORDINALITY AS w(part, n)
                       WHERE w.part NOT LIKE 'OAuth access tokens are not readable % last-login data is unavailable.'
                       ORDER BY w.n
                   ),
                   ' | '
               ) AS rest
        FROM "IamClusterSyncStates" AS st
        WHERE st."Health" = 'Degraded'
          AND st."LastError" LIKE '%OAuth access tokens are not readable % last-login data is unavailable.%'
    ) AS healed
    WHERE s."Id" = healed."Id";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020130000_KiamReadinessRound4') THEN
    UPDATE "ApprovalSteps" AS s
    SET "ApproverLabel" = 'Cluster owner'
    FROM "AccessRequests" AS r
    WHERE s."RequestId" = r."Id"
      AND s."ApproverRef" = 'NamespaceOwner'
      AND s."ApproverLabel" = 'Namespace owner'
      AND (r."Namespace" IS NULL OR btrim(r."Namespace") = '');
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20261020130000_KiamReadinessRound4') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20261020130000_KiamReadinessRound4', '10.0.12');
    END IF;
END $EF$;
COMMIT;

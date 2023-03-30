/* ****************************************************************************
 * $Revision: 49069 $:
 * $Author: Pisan.Jariyasettachok $:
 * $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
 * $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT 
  XleProfiles.Name AS RES_LEGAL_ENTITY,
  XleProfiles.LEGAL_ENTITY_IDENTIFIER AS RES_LEGAL_ENTITY_IDENTIFIER
  
  ,WorkDetail.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,WorkDetail.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,WorkDetail.CREATED_BY  RSC_CREATED_BY
  ,WorkDetail.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,XleProfiles.LEGAL_ENTITY_ID RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
  (SELECT OrganizationUnit.ORGANIZATION_ID, OrganizationUnit.EFFECTIVE_START_DATE,
      OrganizationUnit.BUSINESS_GROUP_ID,
      OrganizationUnit.LEGAL_ENTITY_ID,
      OrganizationUnit.LAST_UPDATED_BY,
      OrganizationUnit.LAST_UPDATE_DATE,
      OrganizationUnit.CREATED_BY ,
      OrganizationUnit.CREATION_DATE
  FROM
    (SELECT OrganizationWorktime.ORGANIZATION_ID,
      OrganizationWorktime.EFFECTIVE_START_DATE
    FROM
      (SELECT OrgInformationEFFDEO.ORGANIZATION_ID,
        OrgInformationEFFDEO.EFFECTIVE_START_DATE
      FROM HR_ORGANIZATION_INFORMATION_F OrgInformationEFFDEO
      WHERE
        OrgInformationEFFDEO.ORG_INFORMATION_CONTEXT = 'PER_LEMP_EMPLOYMENT_INFO'
      ) OrganizationInfo,
      (SELECT OrgInformationEFFDEO.ORGANIZATION_ID,
        OrgInformationEFFDEO.effective_start_date 
      FROM HR_ORGANIZATION_INFORMATION_F OrgInformationEFFDEO
      WHERE
        OrgInformationEFFDEO.ORG_INFORMATION_CONTEXT = 'PER_WORK_DAY_INFO'
      ) OrganizationWorktime
    WHERE OrganizationInfo.ORGANIZATION_ID   = OrganizationWorktime.ORGANIZATION_ID(+)
    AND OrganizationInfo.EFFECTIVE_START_DATE = OrganizationWorktime.EFFECTIVE_START_DATE(+)
    ) WorkDetailInfo,
    HR_ALL_ORGANIZATION_UNITS_F OrganizationUnit
  WHERE WorkDetailInfo.ORGANIZATION_ID(+)    = OrganizationUnit.ORGANIZATION_ID
  AND WorkDetailInfo.EFFECTIVE_START_DATE(+) = OrganizationUnit.EFFECTIVE_START_DATE
  ) WorkDetail ,
  (SELECT XleProfiles.NAME,
    XleProfiles.LEGAL_ENTITY_IDENTIFIER,
    XleProfiles.LEGAL_ENTITY_ID,
    OrganizationUnit.effective_start_date,
    OrganizationUnit.organization_id,
	XleProfiles.LAST_UPDATED_BY,
    XleProfiles.LAST_UPDATE_DATE,
    XleProfiles.CREATED_BY ,
    XleProfiles.CREATION_DATE
  FROM
    (SELECT XleEntityProfiles.NAME,
	  XleEntityProfiles.LEGAL_ENTITY_IDENTIFIER,
      XleEntityProfiles.LEGAL_ENTITY_ID,
      XleEntityProfiles.EFFECTIVE_FROM,
	  XleEntityProfiles.LAST_UPDATED_BY,
      XleEntityProfiles.LAST_UPDATE_DATE,
      XleEntityProfiles.CREATED_BY ,
      XleEntityProfiles.CREATION_DATE
    FROM HZ_GEOGRAPHIES GeographyPEO,
      XLE_ENTITY_PROFILES XleEntityProfiles,
      XLE_ENTITY_PROFILES XleEntityProfiles1
    WHERE ((GeographyPEO.GEOGRAPHY_ID          = XleEntityProfiles.GEOGRAPHY_ID)
    AND(GeographyPEO.GEOGRAPHY_TYPE            = 'COUNTRY')
    AND ((XleEntityProfiles.LEGAL_EMPLOYER_FLAG='Y')
    OR (XleEntityProfiles.PSU_FLAG             ='Y'))
    AND (XleEntityProfiles.PARENT_PSU_ID       = XleEntityProfiles1.LEGAL_ENTITY_ID(+)))
    ) XleProfiles,
    HR_ALL_ORGANIZATION_UNITS_F OrganizationUnit
  WHERE XleProfiles.LEGAL_ENTITY_ID = OrganizationUnit.LEGAL_ENTITY_ID(+)
  AND SYSDATE BETWEEN OrganizationUnit.effective_start_date AND OrganizationUnit.effective_end_date
  ) XleProfiles
  WHERE XleProfiles.LEGAL_ENTITY_ID = WorkDetail.LEGAL_ENTITY_ID
  and XleProfiles.EFFECTIVE_START_DATE = WorkDetail.EFFECTIVE_START_DATE
/*WHERE XleProfiles.organization_id = WorkDetail.organization_id(+)
and XleProfiles.EFFECTIVE_START_DATE = WorkDetail.EFFECTIVE_START_DATE(+)
and XleProfiles.EFFECTIVE_START_DATE IS NOT NULL*/
AND (EXISTS (SELECT 1 FROM HR_ORGANIZATION_INFORMATION_F WHERE ORG_INFORMATION_CONTEXT = 'PER_LEMP_EMPLOYMENT_INFO' AND ORGANIZATION_ID = WorkDetail.organization_id)
        OR EXISTS (SELECT 1 FROM HR_ORGANIZATION_INFORMATION_F WHERE ORG_INFORMATION_CONTEXT = 'PER_WORK_DAY_INFO' AND ORGANIZATION_ID = WorkDetail.organization_id) )

order by XleProfiles.Name
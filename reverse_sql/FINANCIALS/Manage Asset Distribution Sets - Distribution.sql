/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Distribution%20Sets%20-%20Distribution.sql $:
 * $Id: Manage Asset Distribution Sets - Distribution.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- FIELD_TO_APPLY_FUNCTION=RES_EXPENSE_ACCOUNT/GET_CODE_COMBINATION

select DISTRIBUTIONSETEO.name RES_NAME
,BOOKCONTROLPEO.BOOK_TYPE_CODE    RES_BOOK
,DISTRIBUTIONSETDEFAULTEO.UNIT_PERCENTAGE RES_UNIT_PERCENTAGE
,DistributionSetDefaultEO.DEPRN_EXPENSE_CCID RES_EXPENSE_ACCOUNT
,FUSION.FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME   => 'FA',											
											KEY_FLEX_CODE   => 'LOC#',
											STRUCTURE_NUMBER    => (select LOCATION_FLEX_STRUCTURE 	from FA_SYSTEM_CONTROLS	),
											COMBINATION_ID      => DISTRIBUTIONSETDEFAULTEO.LOCATION_ID)  RES_LOCATION
,(LIST_NAME)                     RES_EMPLOYEE_NAME
,PersonDPEO.PERSON_NUMBER RES_EMPLOYEE_NUMBER
  ,DistributionSetDefaultEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,DistributionSetDefaultEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,DistributionSetDefaultEO.CREATED_BY  RSC_CREATED_BY
  ,DistributionSetDefaultEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FA_DISTRIBUTION_DEFAULTS DistributionSetDefaultEO
,PER_PERSON_NAMES_F_V PersonNameDPEO
,PER_ALL_PEOPLE_F PERSONDPEO
,FA_DISTRIBUTION_SETS DistributionSetEO
,FA_BOOK_CONTROLS BOOKCONTROLPEO
where DISTRIBUTIONSETEO.BOOK_TYPE_CODE = BOOKCONTROLPEO.BOOK_TYPE_CODE
and DistributionSetEO.DIST_SET_ID = DistributionSetDefaultEO.DIST_SET_ID
and DISTRIBUTIONSETDEFAULTEO.EMPLOYEE_ID = PERSONNAMEDPEO.PERSON_ID(+)  
and DISTRIBUTIONSETDEFAULTEO.EMPLOYEE_ID = PERSONDPEO.PERSON_ID(+)       
AND(sysdate BETWEEN PersonNameDPEO.EFFECTIVE_START_DATE(+) AND PersonNameDPEO.EFFECTIVE_END_DATE(+))
and(sysdate between PERSONDPEO.EFFECTIVE_START_DATE(+) and PERSONDPEO.EFFECTIVE_END_DATE(+))
order by DISTRIBUTIONSETEO.name 
/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Configure%20Supplier%20Registration%20-%20Default%20Business%20Relationship%20for%20Registration%20Sources.sql $:
 * $Id: Configure Supplier Registration - Default Business Relationship for Registration Sources.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select (select MEANING from FND_LOOKUPS LOOKUPPEO where LOOKUP_TYPE = 'ORA_POZ_BUSINESS_RELATIONSHIP'  and LOOKUP_CODE = SOURCING_BUS_REL_DEFAULT)  RES_SOURCING_INVITATION
,(select MEANING from FND_LOOKUPS LOOKUPPEO where LOOKUP_TYPE = 'ORA_POZ_BUSINESS_RELATIONSHIP'  and LOOKUP_CODE = INTERNAL_BUS_REL_DEFAULT) RES_INTERNAL_SUPPLIER_REQUEST
,(select MEANING from FND_LOOKUPS LOOKUPPEO where LOOKUP_TYPE = 'ORA_POZ_BUSINESS_RELATIONSHIP'  and LOOKUP_CODE = SSP_BUS_REL_DEFAULT) RES_SELF_SERVICE_PROCUREMENT
,null RES_REGISTRATION_URL_ENCRYPTIO
,LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,CREATED_BY  RSC_CREATED_BY
,CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from POZ_SUPPLIER_OPTIONS SUPPLIEROPTIONEO
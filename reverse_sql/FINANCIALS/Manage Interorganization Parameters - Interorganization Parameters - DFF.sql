/* ****************************************************************************
 * $Revision:  $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-04-24 $:
 * $HeadURL:  $:
 * $Id: Manage Interorganization Parameters - Interorganization Parameters - DFF.sql $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=401##RES##INV_INTERORG_PARAMETERS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields. 


SELECT  
(select  AA.ORGANIZATION_CODE
 FROM INV_ORGANIZATION_DEFINITIONS_V  AA
 WHERE AA.ORGANIZATION_ID =  iop.FROM_ORGANIZATION_ID 
 )     																		RES_FROM_ORGANIZATION,
(select  AA.ORGANIZATION_CODE
 FROM INV_ORGANIZATION_DEFINITIONS_V  AA
 WHERE AA.ORGANIZATION_ID =  iop.TO_ORGANIZATION_ID      
)    																		RES_TO_ORGANIZATION
,iop.ATTRIBUTE_CATEGORY 						RES_CONTEXT_CODE
,iop.ATTRIBUTE1
,iop.ATTRIBUTE2
,iop.ATTRIBUTE3
,iop.ATTRIBUTE4
,iop.ATTRIBUTE5
,iop.ATTRIBUTE6
,iop.ATTRIBUTE7
,iop.ATTRIBUTE8
,iop.ATTRIBUTE9
,iop.ATTRIBUTE10
,iop.ATTRIBUTE11
,iop.ATTRIBUTE12
,iop.ATTRIBUTE13
,iop.ATTRIBUTE14
,iop.ATTRIBUTE15
,iop.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,iop.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,iop.CREATED_BY RSC_CREATED_BY
,iop.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null   RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

 from INV_INTERORG_PARAMETERS  iop
 WHERE(iop.ATTRIBUTE_CATEGORY IS NOT NULL
OR iop.ATTRIBUTE1            IS NOT NULL
OR iop.ATTRIBUTE2            IS NOT NULL
OR iop.ATTRIBUTE3            IS NOT NULL
OR iop.ATTRIBUTE4            IS NOT NULL
OR iop.ATTRIBUTE5            IS NOT NULL
OR iop.ATTRIBUTE6            IS NOT NULL
OR iop.ATTRIBUTE7            IS NOT NULL
OR iop.ATTRIBUTE8            IS NOT NULL
OR iop.ATTRIBUTE9            IS NOT NULL
OR iop.ATTRIBUTE10           IS NOT NULL
OR iop.ATTRIBUTE11           IS NOT NULL
OR iop.ATTRIBUTE12           IS NOT NULL
OR iop.ATTRIBUTE13           IS NOT NULL
OR iop.ATTRIBUTE14           IS NOT NULL
OR iop.ATTRIBUTE15           IS NOT NULL)
ORDER BY iop.FROM_ORGANIZATION_ID 
